#only search app and lib Dir
#xiangwei 31531640@qq.com

require 'optparse'


$KCODE='utf-8'
require 'jcode'
require'iconv'  
class String  
  def to_gbk  
    Iconv.iconv("GBK//IGNORE","UTF-8//IGNORE",self).to_s  
  end  
  def to_utf8  
    Iconv.iconv("UTF-8//IGNORE","GBK//IGNORE",self).to_s  
  end  
end 



# This hash will hold all of the options
# parsed from the command-line by
# OptionParser.
options = {}



optparse = OptionParser.new do|opts|
  # Set a banner, displayed at the top
  # of the help screen.
  opts.banner = "Search in Rails Files: grep.rb [options] pattern"

  # Define the options, and what they do
  options[:all] = false
  opts.on( '-a', '--all', 'Search All File Types' ) do
    options[:all] = true
  end

  options[:cpp] = false
  opts.on( '-c', '--cpp', 'Search cpp File Types' ) do
    options[:cpp] = true
  end

  options[:ignore] = false
  opts.on( '-i', '--ignore', 'Ignore Case Sensative' ) do
    options[:ignore] = true
  end

  options[:plain] = false
  opts.on( '-p', '--plain', 'Don\'t use regex' ) do
    options[:plain] = true
  end

  opts.on( '-h', '--help', 'Helping' ) do
    puts opts
    exit
  end
end

optparse.parse!

keyword = ARGV.join(' ') 

$filetypes='*.{rb,erb,rjs,yml,haml,rake,builder,js,css,rhtml}'
$filetypes = '*' if options[:all] 
$filetypes = '*.{c,cpp,h,hpp,txt,rc,s,asm}' if options[:cpp]

Dir.glob("**/#{$filetypes}").each {|fileName|
  next if (fileName=~/(\.svn|\.git)\// || fileName=~/^(tmp|vendor)\//)
  count = 0
  next if File.directory?(fileName)
  File.new(fileName, 'r').each_line{ |line|
    count +=1
    if options[:plain]
      if options[:ignore]
        puts (fileName+":#{count}: "+line).to_utf8 if line.upcase.include?(keyword.upcase)
      else
        puts (fileName+":#{count}: "+line).to_utf8 if line.include?(keyword)
      end
    else
      if options[:ignore]
        puts((fileName+":#{count}: "+line).to_utf8) if line=~/#{keyword}/i 
      else
        puts((fileName+":#{count}: "+line).to_utf8) if line=~/#{keyword}/
      end
    end
  }
}
