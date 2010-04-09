
command = ARGV[0]
shell = Win32API.new("shell32", "ShellExecute", ['L', 'P', 'P', 'P', 'P', 'L'], 'L')
puts command
case command.to_i
  when 0
    shell.Call(0, "open", "ProgrammingRuby.chm", "", 0, 1)
  when 1
    shell.Call(0, "open", 'rails_guides\index.html', "", 0, 1)
  when 2
    shell.Call(0, "open", 'rdoc\index.html', "", 0, 1)
  when 3
    shell.Call(0, "open", 'c:\ruby\lib\ruby\gems\1.8\gems', '', 0, 1)
  when 4
    shell.Call(0, "open", 'http://127.0.0.1:3000', '', 0, 1)
end

