Puppet::Type.newtype(:smb_user) do
  desc 'The smb_user type manages usernames and passwords for samba shares'
  ensurable
  newparam(:user, :namevar => true) do
    desc 'The user is the username of a samba share'
    validate do |value|
      fail("#{user} is not a valid username") unless value =~ /^[a-zA-Z0-9\-\_]+$/
    end
  end
  newproperty(:password) do
    desc 'The password is the user\'s password of a samba user'
    validate do |value|
      fail("Password should be at least 3 characters") unless value =~ /^...+$/
    end
    munge do |value|
      cmd = "printf '" + value  + "' | iconv -f ASCII -t UTF-16LE | openssl dgst -md4 | tr '[:lower:]' '[:upper:]' | cut -d ' ' -f2"
      exec( cmd )
    end
  end
end
