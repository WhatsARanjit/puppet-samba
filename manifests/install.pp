class samba::install {
  package { 'samba':
    ensure => installed,
  }
  group { 'samba':
    ensure => present,
  }
  user { 'samba':
    ensure => present,
    groups => 'samba',
  }
}
