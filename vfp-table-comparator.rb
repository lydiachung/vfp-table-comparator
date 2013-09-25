
require "rubygems"
require "dbf"

class VFPTableComparator

  def connect()
    s_file_name = File.join("d:","ltuf","P8","system","alertmsg.dbf")
    puts s_file_name
    widgets = DBF::Table.new(s_file_name)
    widgets.each do |record|
      puts "#{record.alertid}: #{record.alert}"
    end        
  end
   
end


VFPTableComparator.new.connect