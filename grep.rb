#only search app and lib Dir
#xiangwei 31531640@qq.com
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

case ARGV[0]
when '-a'
  $search_pattern = /#{ARGV[1]}/
  $filetypes = '*'
when '-c'
  $search_pattern = /#{ARGV[1]}/
  $filetypes = '*.{c,cpp,h,hpp,txt,rc,s,asm}'
else
  $search_pattern = /#{ARGV[0]}/
  $filetypes='*.{rb,erb,rjs,yml,haml,rake}'
end


Dir.glob("**/#{$filetypes}").each {|fileName|
  next if (fileName=~/(\.svn|\.git)\// || fileName=~/^(tmp|vendor)\//)
  count = 0
  next if File.directory?(fileName)
  File.new(fileName, 'r').each_line{ |line|
    count +=1
    puts (fileName+":#{count}: "+line).to_utf8 if line=~$search_pattern
  }
}
