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


$search_pattern = /#{ARGV[0]}/

Dir.glob('{app,lib}/**/*.{rb,erb,rjs,yml,haml}').each {|fileName|
  next if fileName=~/\/(\.svn|\.git)\//
  #next if fileName=~/\/(tmp|vendor|log|spec|\.svn|\.git)\//
  count = 0
  File.new(fileName, 'r').each_line{ |line|
    count +=1
    #d-+kdk
    puts (fileName+":#{count}: "+line).to_utf8 if line=~$search_pattern
  }
}
#puts "test/t.rb"=~/(?!test)\/.*/
#
