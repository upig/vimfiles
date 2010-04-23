=begin
1. 通过set，获取ruby路径, user profile路径
2. 修改_vimrc文件
=end

#`set` =~ /^USERPROFILE=(.*?)$/
#user_path = $1

vimfiles_path = File.expand_path(File.dirname(__FILE__))
puts "vimfiles_path: #{vimfiles_path}"

temp_path = ENV["temp"].gsub('\\', '/')
puts "temp_path: #{temp_path}"

ruby_path_bin =  'c:\ruby\bin'

ENV['PATH'].split(';').each {|path|
  ruby_path_bin = path if path =~/.*ruby.*bin/i
}
puts "ruby_path_bin: #{ruby_path_bin}"

puts 'Generating _vimrc'

File.open('_vimrc', 'r'){ |f|
  @str = f.read
}

@str.gsub!('C:/Documents and Settings/magic/vimfiles/;C:/GnuWin32/bin', vimfiles_path)
@str.gsub!('@XWPATH@', vimfiles_path)
@str.gsub!('@TEMPPATH@', temp_path)

File.open('../_vimrc', 'w'){|f|
  f.write(@str)
}

command = ARGV[0]
shell = Win32API.new("shell32", "ShellExecute", ['L', 'P', 'P', 'P', 'P', 'L'], 'L')
shell.Call(0, "open", 'c:\WINDOWS\Fonts', '', 0, 1)

require 'ftools'
File.copy('grep.rb', ruby_path_bin)

puts 'Open windows Fonts, please copy MONACO.TTF to this window...'
puts 'Press anything to exit! '


`pause`


