Puppet::Type.type(:smb_share).provide(:smb_share) do
  confine :kernel => :linux
  defaultfor :kernel => :linux
  commands :awk => 'awk', :echo => 'echo', :pcregrep => 'pcregrep', :grep => 'grep'

  def exists?
    begin
      pcregrep("-soM", "'\[" + resource[:share] + "\]\n(.*?\n)+# END " + resource[:share] + " #' ", "/etc/samba/smbshares")
    rescue Puppet::ExecutionFailure => e
      false
    end
  end

  def create
    output = "\n[#{resource[:share]}]\n"
    resource.each do |k,v|
      output << "#{k} = #{v}\n" unless k == :share
    end
    output << "# END #{resource[:share]} #"
    echo("-e", "\"" + output + "\"", ">>", "/etc/samba/smbpasswd")
  end

  resource.each do |k,v|
    param = k.to_s
    def k
      k = awk("'/\[" + resource[:share] + "\]/,", "/# END " + resource[:share] + " #/", "/etc/samba/smbpasswd", "|", "grep", "\"" + v + "\"")
      if k =~ /^.*?:.*?:.*?:(.*):.*?:$/
        $1
      end
    end

    def k=(value)
      awk("'/\[" + resource[:share] + "\]/,", "/# END " + resource[:share] + " #/", "{", "sub(/^" + k + " = .*$/,", "\"" + v + "\")}", "1'", "/etc/samba/smbpasswd")
    end
  end

  def destroy
     new = pcregrep("-svM", "'^\[" + resource[:share] + "\]$[\t\sa-zA-Z=\/\;\%]+# END " + resource[:share] + " #\n'", "/etc/samba/smbpasswd")
     echo(new, ">", "/etc/samba/smbpasswd") 
  end

end
