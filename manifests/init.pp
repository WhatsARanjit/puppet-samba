class samba {
  class { 'samba::install': }
  class { 'samba::service':
    require => Class['samba::install'],
  }
}

