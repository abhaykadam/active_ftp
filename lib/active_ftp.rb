require 'net/ftp'

class ActiveFtp < Net::FTP
  
  def rm_r(path)
    depth_first(path)
  end
  
private
  def depth_first(path)
    contents = list(path) #...contents may dir and files both
    
    contents = contents.map(&:split).delete_if{|e| e.length < 9} #removes OS X "total 0" row
    
    return if(contents.length == 0)
    
    dirs = contents.select{|e| e[0].start_with? 'd'}.map {|e| e.drop(8)}.map {|e|e.join " "}
      .each {|dir| depth_first(path + '/' + dir); rmdir(path + '/' + dir);}
    
    files = contents.select{|e| e[0].start_with? '-'}.map {|e| e.drop(8)}.map {|e|e.join " "}
      .each {|file| delete(path + '/' + file)}
  end
end
