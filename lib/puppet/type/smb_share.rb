require 'pathname'
Puppet::Type.newtype(:smb_share) do
  desc 'The smb_share type manages samba shares and their values'
  ensurable
  newparam(:path, :namevar => true) do
    desc 'The location of a samba share'
    validate do |value|
      unless Pathname.new(value).absolute?
        fail("Invalid path #{value}")
    end
  end
  newproperty(:comment) do
    desc 'The comment is a description field'
  end
  newproperty(:browseable) do
    newvalue(:yes)
    newvalue(:no)
  end
  newproperty(:writeable) do
    newvalue(:yes)
    newvalue(:no)
  end
  newproperty(:valid_users) do
  end
  newproperty(:guest_ok) do
    newvalue(:yes)
    newvalue(:no)
  end
  newproperty(:printable) do
    newvalue(:yes)
    newvalue(:no)
  end
  newproperty(:share_modes) do
    newvalue(:yes)
    newvalue(:no)
  end
  newproperty(:public) do
    newvalue(:yes)
    newvalue(:no)
  end
  newproperty(:write_list) do
  end
  newproperty(:public) do
    newvalue(:yes)
    newvalue(:no)
  end
  newproperty(:hide_dot_files) do
    newvalue(:yes)
    newvalue(:no)
  end
end