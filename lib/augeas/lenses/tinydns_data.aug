module Tinydns_data =
  autoload xfm
  
  let eol = Util.eol
  let sep = Sep.colon

  let sto_to_com_def = store ( /[.=+]/ )
  
  let sto_to_com_name = store ( /[A-Za-z0-9_.-]+/ )

  let sto_to_com_ip = store ( /[0-9.]+/ )

  let sto_to_com_class = store ( /[a-z]/ )
  
  let sto_to_com_expiry = store ( /[0-9]+/ )
  

  let alias_field (kw:string) (sto:lens) = [ label kw . sto ]
  
  
  let spec = [ label "spec"
               . alias_field "def" sto_to_com_def
               . alias_field "name" sto_to_com_name . sep
               . alias_field "ip" sto_to_com_ip . sep
               . (alias_field "class" sto_to_com_class . sep)?
               . alias_field "expiry" sto_to_com_expiry
               . eol ]
  
  let lns = ( spec )*

  let filter = (incl "/var/lib/tinydns/root/data") .
               (excl "*.bak") .
               Util.stdexcl

  let xfm = transform lns filter
  