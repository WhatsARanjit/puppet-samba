smb_share { 'foo':
  #ensure     => absent,
  path       => '/tmp/smb',
  comment    => "This is a test",
  public     => "yes",
  guest_ok   => "yes",
  browseable => "yes",
}
