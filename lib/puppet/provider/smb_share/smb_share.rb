Puppet::Type.type(:smb_share).provide(:smb_share) do
  confine :kernel => :linux
  defaultfor :kernel => :linux
  commands :awk => 'awk', :pcregrep => 'pcregrep', :grep => 'grep'

  def exists?
    require 'pry'
    binding.pry
    begin
      regex = "\\[" + resource.title + "\\]\\n(.*?\\n)+# END " + resource.title + " #"
      pcregrep("-soM", regex, "/etc/samba/smbshares")
    rescue Puppet::ExecutionFailure => e
      false
    end
  end

  def create
    output = "\n[#{resource.title}]\n"
    #output << "path = #{resource[:path]}\n"
    resource.original_parameters.each do |k,v|
      output << "#{k} = #{v}\n"
    end
    output << "# END #{resource.title} #"
    File.open('/etc/samba/smbshares', 'a') { |file| file.write(output) }
  end

  #@resource.each do |k,v|
  #  param = k.to_s
  #  def k
  #    k = awk("'/\[" + resource[:path] + "\]/,", "/# END " + resource[:path] + " #/", "/etc/samba/smbpasswd", "|", "grep", "\"" + v + "\"")
  #    if k =~ /^.*?:.*?:.*?:(.*):.*?:$/
  #      $1
  #    end
  #  end

  #  def k=(value)
  #    awk("'/\[" + resource[:path] + "\]/,", "/# END " + resource[:path] + " #/", "{", "sub(/^" + k + " = .*$/,", "\"" + v + "\")}", "1'", "/etc/samba/smbpasswd")
  #  end
  #end

  def destroy
    new = pcregrep("-svM", "'^\[" + resource.title + "\]$[\t\sa-zA-Z=\/\;\%]+# END " + resource.title + " #\n'", "/etc/samba/smbshares")
    File.open('/etc/samba/smbshares', 'w') { |file| file.write(new) }
  end

end
