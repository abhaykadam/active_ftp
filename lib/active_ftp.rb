require 'net/ftp'
require 'net/ftp/list'

require 'logger'
$log = Logger.new('active_ftp.log', 'monthly')

class ActiveFtp < Net::FTP

  def rm_r(path)
    $log.debug {'In rm_r()'}
    dir_oper = Proc.new {|abs_dir| rmdir abs_dir}
    file_oper = Proc.new {|abs_file| delete abs_file}

    $log.debug {"Starting removing tree at #{path}"}
    depth_first(path, dir_oper, file_oper)

    true
  end

private
  def depth_first(path, dir_oper, file_oper)

    list(path).each do |e|
      entry = Net::FTP::List.parse(e)

      entry_path = File.join(path, entry.basename)

      if entry.dir?
        $log.debug {"In #{entry.basename} directory"}

        depth_first(entry_path, dir_oper, file_oper)
        dir_oper.call entry_path
      elsif entry.file?
        $log.debug {"At #{entry.basename} file"}

        file_oper.call entry_path
      end
    end
  end
end
