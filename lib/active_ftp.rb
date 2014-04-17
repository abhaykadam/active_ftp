require 'net/ftp'

class ActiveFtp < Net::FTP
  
  def rm_r(path)
    dir_oper = Proc.new {|abs_dir| rmdir abs_dir}
    file_oper = Proc.new {|abs_file| delete abs_file}
    depth_first(path, dir_oper, file_oper)
  end
  
private
  def depth_first(path, dir_oper, file_oper)
    contents = list(path) #...contents may dir and files both
    
    contents = contents.map(&:split).delete_if{|e| e.length < 9} #removes OS X "total 0" row
    
    return if(contents.length == 0)
    
    dirs = contents.select{|e| e[0].start_with? 'd'}.map {|e| e.drop(8)}.map {|e|e.join " "}
      .each {|dir| depth_first(path + '/' + dir, dir_oper, file_oper); dir_oper.call(path + '/' + dir);}
    
    files = contents.select{|e| e[0].start_with? '-'}.map {|e| e.drop(8)}.map {|e|e.join " "}
      .each {|file| file_oper.call(path + '/' + file)}
  end
end