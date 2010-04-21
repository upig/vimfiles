ruby_path =  'c:\ruby'
dos_env = `set`
if dos_env=~/PATH=.*;(.*?ruby.*?)\\bin/i
  ruby_path = $1
end

vimfiles_path = File.expand_path(File.dirname(__FILE__))
command = ARGV[0]
shell = Win32API.new("shell32", "ShellExecute", ['L', 'P', 'P', 'P', 'P', 'L'], 'L')
puts command
case command.to_i
  when 0
    shell.Call(0, "open", '"'+vimfiles_path+'\ProgrammingRuby.chm"', "", 0, 1)
  when 1
    shell.Call(0, "open", '"'+vimfiles_path+'\rails_guides\index.html"', "", 0, 1)
  when 2
    shell.Call(0, "open", '"'+vimfiles_path+'\rdoc\index.html"', "", 0, 1)
  when 3
    shell.Call(0, "open", ruby_path+'\lib\ruby\gems\1.8\gems', '', 0, 1)
  when 4
    shell.Call(0, "open", 'http://127.0.0.1:3000', '', 0, 1)
  when 5
    shell.Call(0, "open", '"'+vimfiles_path+'\0_Agile Web Development with Rails 3nd Edition Beta.pdf"', "", 0, 1)
  when 6
    shell.Call(0, "open", '"'+vimfiles_path+'\xw_docs_more"', "", 0, 1)
end

