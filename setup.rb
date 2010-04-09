puts 'Generating _vimrc'

File.open('_vimrc', 'r'){ |f|
  @str = f.read
}

@str.gsub!('C:/Documents and Settings/magic/vimfiles/;C:/GnuWin32/bin', File.expand_path(File.dirname(__FILE__)))

File.open('../_vimrc', 'w'){|f|
  f.write(@str)
}

#puts `copy MONACO.TTF C:\WINDOWS\Fonts`


command = ARGV[0]
shell = Win32API.new("shell32", "ShellExecute", ['L', 'P', 'P', 'P', 'P', 'L'], 'L')
shell.Call(0, "open", 'c:\WINDOWS\Fonts', '', 0, 1)

puts 'Open windows Fonts, please copy MONACO.TTF to this window, and press anything to exit'


`pause`


