Puppet::Type.type(:smb_share).provide(:smb_share) do
  confine :kernel => :linux
  defaultfor :kernel => :linux
  commands :grep => 'grep', :echo => 'echo', :pcregrep => 'pcregrep'

  def exists?
    begin
      pcregrep("-soM", "'\[" + resource[:share] + "\]\n(.*?\n)+# END " + resource[:share] + "#' ", "/etc/samba/smbshares")
    rescue Puppet::ExecutionFailure => e
      false
    end
  end

  def create
    echo("-e", "\"" + resource[:password] + "\n" + resource[:password] + "\"", "|", "smbpasswd", "-as", resource[:user])
  end

  def password
    password = grep("-sP", "\"^" + resource[:user] + "\"", "/etc/samba/smbpasswd")
    if password =~ /^.*?:.*?:.*?:(.*):.*?:$/
      $1
    end
  end

  def password=(value)
    echo("-e", "\"" + resource[:password] + "\n" + resource[:password] + "\"", "|", "smbpasswd", "-s", resource[:user])
  end

  def destroy
    smbpasswd('-x', resource[:user])
  end

end
