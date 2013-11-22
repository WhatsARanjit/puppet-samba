Puppet::Type.type(:smb_user).provide(:smbpasswd) do
  confine :kernel => :linux
  defaultfor :kernel => :linux
  commands :smbpasswd => 'smbpasswd', :grep => 'grep', :iconv => 'iconv', :echo => 'echo'

  def exists?
    begin
      grep("-sP", "^" + resource[:user] + ": /etc/samba/smbpasswd")
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
