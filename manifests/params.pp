class samba::params {
  # Global Settings
  case $::operatingsystem {
    /(Ubuntu|Debian)/: {
      $service_name = 'samba'
    }
    default: {
      $service_name = [ 'smb', 'nmb']
    }
  }
  $ensure = 'running'
  $workgroup = 'MYGROUP'
  $server_string = 'Samba Server Version %v'
  $netbios_name = ''
  $interfaces = ''
  $hosts_allow = ''
  # Logging Options
  $log_file = '/var/log/samba/log.%m'
  $max_log_size = 50
  # Security Options
  $security = 'user'
  $passdb_backend = 'tdbsam'
  $realm = ''
  $password_server = ''
  # Domain Controller
  $domain_master = ''
  $domain_logons = ''
  $logon_script = ''
  $add_user_script = ''
  $add_group_script = ''
  $add_machine_script = ''
  $delete_user_script = ''
  $delete_group_script = ''
  $delete_user_from_group_script = ''
  $delete_machine_script = ''
  # Browser Control
  $local_master = ''
  $os_level = ''
  $preferred_master = ''
  # Name Resolution
  $wins_support = ''
  $wins_server = ''
  $wins_proxy = ''
  $dns_proxy = ''
  # Printing Options
  $load_printers = 'yes'
  $cups_options = 'raw'
  $printcap_name = ''
  $printing = ''
  # Filesystem Options
  $map_archive = ''
  $map_hidden = ''
  $map_read_only = ''
  $map_system = ''
  $store_dos_attributes = ''
}
