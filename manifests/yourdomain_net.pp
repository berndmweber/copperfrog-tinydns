# Configure the DNS settings
#
class tinydns::yourdomain_net::ns_setup {
  # This defines the DNS server commons
  Tinydns::Add_dns_entry {
    type => 'ns',
    ip => '10.10.10.4',
  }
  # DNS address range setting
  tinydns::add_dns_entry { '10.10.10.in-addr.arpa' :
    expiry => '3600',
  }
  # DNS domain setting
  tinydns::add_dns_entry { [ 'yourdomain.net',
                           ] :
    expiry => '3600',
    require => Tinydns::Add_dns_entry [ '10.10.10.in-addr.arpa' ],
  }
  # Enable the subnet access according to above address range setting
  tinydns::enable_subnet_access { [ "10.10.10",
                                  ] : }
}

# Configure hosts on your network
#
class tinydns::yourdomain_net::host_setup {
  Tinydns::Add_dns_entry {
    type => 'host',
    expiry => '7200',
    require => Class [ 'tinydns::yourdomain_net::ns_setup' ],
  }
  tinydns::add_dns_entry { 'server1.yourdomain.net' :
    ip => '10.10.10.1',
  }
  tinydns::add_dns_entry { 'server2.yourdomain.net' :
    ip => '10.10.10.2',
  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.3',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.4',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.5',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.6',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.7',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.8',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.9',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.10',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.11',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.12',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.13',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.14',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.15',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.16',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.17',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.18',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.19',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.20',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.21',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.22',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.23',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.24',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.25',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.26',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.27',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.28',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.29',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.30',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.31',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.32',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.33',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.34',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.35',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.36',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.37',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.38',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.39',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.40',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.41',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.42',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.43',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.44',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.45',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.46',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.47',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.48',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.49',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.50',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.51',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.52',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.53',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.54',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.56',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.57',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.58',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.59',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.60',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.61',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.62',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.63',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.64',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.65',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.66',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.67',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.68',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.69',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.70',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.71',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.72',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.73',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.74',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.75',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.76',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.77',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.78',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.79',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.80',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.81',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.82',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.83',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.84',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.85',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.86',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.87',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.88',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.89',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.90',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.91',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.92',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.93',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.94',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.95',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.96',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.97',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.98',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.99',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.100',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.101',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.102',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.103',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.104',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.105',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.106',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.107',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.108',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.109',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.110',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.111',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.112',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.113',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.114',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.115',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.116',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.117',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.118',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.119',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.120',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.121',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.122',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.123',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.124',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.125',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.126',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.127',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.128',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.129',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.130',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.131',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.132',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.133',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.134',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.135',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.136',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.137',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.138',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.139',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.140',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.141',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.142',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.143',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.144',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.145',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.146',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.147',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.148',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.149',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.150',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.151',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.152',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.153',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.154',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.155',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.156',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.157',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.158',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.159',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.160',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.161',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.162',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.163',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.164',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.165',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.166',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.167',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.168',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.169',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.170',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.171',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.172',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.173',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.174',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.175',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.176',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.177',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.178',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.179',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.180',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.181',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.182',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.183',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.184',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.185',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.186',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.187',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.188',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.189',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.190',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.191',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.192',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.193',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.194',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.195',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.196',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.197',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.198',
#  }
#  tinydns::add_dns_entry { '.yourdomain.net' :
#    ip => '10.10.10.199',
#  }

  ######################################################
  # Removed Section                                    #
  ######################################################
  tinydns::rem_dns_entry { [
    'server3.yourdomain.net',
  ] : }

  ######################################################
  # DHCP Section - Do NOT assign IPs higher than 199!! #
  ######################################################

  # External machines - Begin
  tinydns::add_dns_entry { 'extserver1.externaldomain.net' :
    ip => '66.77.88.55',
  }
  tinydns::add_dns_entry { 'extserver1.externaldomain.net' :
    ip => '66.77.88.99',
  }
  # External machines - End
}

# Configure aliases for existing IP's
#
class tinydns::yourdomain_net::alias_setup {
  Tinydns::Add_dns_entry {
    type => 'alias',
    expiry => '7200',
    require => Class [ 'tinydns::yourdomain_net::host_setup' ],
  }
  tinydns::add_dns_entry { 'ns.yourdomain.net' :
    ip => '10.10.10.1',
  }
  tinydns::add_dns_entry { 'mail.yourdomain.net' :
    ip => '10.10.10.2',
  }
}

class tinydns::yourdomain_net {
  class { 'tinydns::yourdomain_net::ns_setup' : }
  class { 'tinydns::yourdomain_net::host_setup' : }
  class { 'tinydns::yourdomain_net::alias_setup' : }
}
