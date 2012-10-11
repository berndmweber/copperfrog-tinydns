class tinydns::install {
  case $::operatingsystem {
    'Ubuntu' : {
      package { [ 'daemontools',
                  'daemontools-run',
                  'ucspi-tcp',
                  'djbdns',
                ] :
        ensure => present,
      }
    }
    default : {
      alert ("${::operatingsystem} is currently not supported.")
    }
  }
}

define tinydns::add_dns_entry ( $type, $ip, $expiry ) {
  Exec {
    path => "${tinydns::tinydns_root_dir}:.:/bin:/sbin:/usr/bin:/usr/sbin",
    cwd => $tinydns::tinydns_root_dir,
    unless => "grep ${name} ${tinydns::tinydns_data}",
    notify => Exec [ 'remake-data' ],
    require => File [ $tinydns::tinydns_data ],
  }
  Augeas {
    context => "/files${tinydns::tinydns_data}",
    lens => "Tinydns_data.lns",
    incl => $tinydns::tinydns_data,
    load_path => "/var/opt/lib/pe-puppet/lib/augeas/lenses",
    changes => [ "set spec[name = \"${name}\"]/ip ${ip}",
                 "set spec[name = \"${name}\"]/expiry ${expiry}",
               ],
    notify => Exec [ 'remake-data' ],
  }
  case $type {
    'host' : {
      exec { "add-host-${name}" :
        command => "add-host ${name} ${ip}",
      }
      augeas { "change-host-${name}" :
        require => Exec [ "add-host-${name}" ],
      }
    }
    'alias' : {
      exec { "add-alias-${name}" :
        command => "add-alias ${name} ${ip}",
      }
      augeas { "change-alias-${name}" :
         require => Exec [ "add-alias-${name}" ],
      }
    }
    'ns' : {
      exec { "add-ns-${name}" :
        command => "add-ns ${name} ${ip}",
      }
      augeas { "change-ns-${name}" :
        require => Exec [ "add-ns-${name}" ],
      }
      file { "${tinydns::dnscache_servers_dir}/${name}" :
        ensure => file,
        content => "127.0.0.1\n10.10.20.4\n",
        mode => 0644,
      }
    }
  }
}

define tinydns::rem_dns_entry () {
  augeas { "remove-dns-entry-${name}" :
    context => "/files${tinydns::tinydns_data}",
    lens => "Tinydns_data.lns",
    incl => $tinydns::tinydns_data,
    load_path => "/var/opt/lib/pe-puppet/lib/augeas/lenses",
    changes => [ "rm spec[name = \"${name}\"]" ],
    notify => Exec [ 'remake-data' ],
  }
}

class tinydns::configure ( $external_IP ) {
  case $::operatingsystem {
    'Ubuntu' : {
      user { [ 'dnslog',
               'tinydns',
               'syncdns',
               'dnscache',
             ] :
        ensure => present,
        managehome => false,
        shell => '/bin/false',
        require => Class [ 'tinydns::install' ],
      }
      exec { "configure-tinydns-IP" :
        path => "/bin:/sbin:/usr/bin:/usr/sbin",
        command => "tinydns-conf tinydns dnslog ${tinydns::tinydns_install_path} ${external_IP}",
        creates => $tinydns::tinydns_install_path,
      }
      exec { "configure-dnscache-IP" :
        path => "/bin:/sbin:/usr/bin:/usr/sbin",
        command => "dnscache-conf dnscache dnslog ${tinydns::dnscache_install_path} ${::ipaddress}",
        creates => $tinydns::dnscache_install_path,
      }
      file { '/etc/service' :
        ensure => directory,
      }
      file { $tinydns::tinydns_svc :
        ensure => link,
        target => $tinydns::tinydns_install_path,
        require => [ Exec [ 'configure-tinydns-IP' ], File [ '/etc/service' ] ],
      }
      file { $tinydns::tinydns_data :
        ensure => file,
        require => File [ $tinydns::tinydns_svc ],
      }
      file { $tinydns::dnscache_svc :
        ensure => link,
        target => $tinydns::dnscache_install_path,
        require => [ Exec [ 'configure-dnscache-IP', 'configure-tinydns-IP' ], File [ '/etc/service' ] ],
      }
      file { [ $tinydns::dnscache_root_dir,
               $tinydns::dnscache_ip_dir,
               $tinydns::dnscache_servers_dir,
             ] :
        ensure => directory,
      }
      file { "${tinydns::dnscache_ip_dir}/127.0.0.1" :
        ensure => file,
        mode => 0600,
      }
    }
  }
}

define tinydns::enable_subnet_access () {
  file { "${tinydns::dnscache_ip_dir}/${name}" :
    ensure => file,
    mode => 0600,
    notify => Exec [ 'dnscache-restart' ],
  }
}

class tinydns::service {
  Exec {
    path => "/bin:/sbin:/usr/bin:/usr/sbin",
    user => 'root',
  }
  exec { "svscan-start" :
    command => "initctl start svscan",
    unless => 'ps aux | grep svscan | grep -v grep',
    require => Class [ 'tinydns::configure' ],
  }
  exec { "tinydns-start" :
    command => "svc -u ${tinydns::tinydns_svc}",
    unless => "svstat ${tinydns::tinydns_svc} | grep up",
    require => Exec [ 'svscan-start' ],
  }
  exec { "dnscache-start" :
    command => "svc -u ${tinydns::dnscache_svc}",
    unless => "svstat ${tinydns::dnscache_svc} | grep up",
    require => Exec [ 'svscan-start' ],
  }
  exec { "tinydns-restart" :
    command => "svc -t ${tinydns::tinydns_svc}",
    refreshonly => true,
    subscribe => File [ $tinydns::tinydns_data ],
    require => Exec [ 'tinydns-start' ],
  }
  exec { "dnscache-restart" :
    command => "svc -t ${tinydns::dnscache_svc}",
    refreshonly => true,
    subscribe => Exec [ 'tinydns-restart' ],
    require => Exec [ 'tinydns-start' ],
  }
  exec { 'remake-data' :
    path => "${tinydns::tinydns_root_dir}:.:/bin:/sbin:/usr/bin:/usr/sbin",
    cwd => $tinydns::tinydns_root_dir,
    command => "make",
    refreshonly => true,
    subscribe => File [ $tinydns::tinydns_data ],
    notify => Exec [ 'tinydns-restart' ],
  }
}

class tinydns ( $external_IP = '127.0.0.1' ) {
  if $::tinydns_ext_ip != undef {
    $t_external_IP = $::tinydns_ext_ip
  } else {
    $t_external_IP = $external_IP
  }

  $tinydns_svc = '/etc/service/tinydns'
  $tinydns_install_path = '/var/lib/tinydns'
  $tinydns_root_dir = "${tinydns_install_path}/root"
  $tinydns_data = "${tinydns_root_dir}/data"
  $dnscache_svc = '/etc/service/dnscache'
  $dnscache_install_path = '/var/lib/dnscache'
  $dnscache_root_dir = "${dnscache_install_path}/root"
  $dnscache_ip_dir = "${dnscache_root_dir}/ip"
  $dnscache_servers_dir = "${dnscache_root_dir}/servers"

  class { 'tinydns::install' : }
  class { 'tinydns::configure' :
    external_IP => $t_external_IP,
  }
  class { 'tinydns::service' : }
}
