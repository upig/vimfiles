=begin
1. 通过set，获取ruby路径, user profile路径
2. 修改_vimrc文件
=end

#`set` =~ /^USERPROFILE=(.*?)$/
#user_path = $1

vimfiles_path = File.expand_path(File.dirname(__FILE__))

puts 'Generating _vimrc'

File.open('_vimrc', 'r'){ |f|
  @str = f.read
}

@str.gsub!('C:/Documents and Settings/magic/vimfiles/;C:/GnuWin32/bin', vimfiles_path)
@str.gsub!('@XWPATH@', vimfiles_path)

File.open('../_vimrc', 'w'){|f|
  f.write(@str)
}

command = ARGV[0]
shell = Win32API.new("shell32", "ShellExecute", ['L', 'P', 'P', 'P', 'P', 'L'], 'L')
shell.Call(0, "open", 'c:\WINDOWS\Fonts', '', 0, 1)

puts 'Open windows Fonts, please copy MONACO.TTF to this window, and press anything to exit'


`pause`

