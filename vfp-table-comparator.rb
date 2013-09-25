#require 'win32ole'
#require 'sequel'
require "rubygems"
require "dbf"


class VFPTableComparator

    def connect()
      #begin
      # D:\ltuf\P8\system\alertmsg.dbf
        s_file_name = File.join("d:","ltuf","P8","system","alertmsg.dbf")
        puts s_file_name
        widgets = DBF::Table.new(s_file_name)
        widgets.each do |record|
          puts "#{record.alertid}: #{record.alert}"
        end
        

 #     Sequel.connect(:database=>'LTUF AppMenu')
 #       
 #       return
 #       o_conn = WIN32OLE.new('ADODB.Connection')
 #       o_conn.open("LTUF AppMenu")
 #       
 #       s_sql = "select * from alertmsg where alertid < 20"
 #       o_rs = WIN32OLE.new('ADODB.Recordset')
 #       #o_rs.open("alertmsg", o_conn)
 #       o_rs.open(s_sql, o_conn)
 #       o_rs.fields.each do |field|
 #           puts field.Name
 #       end
 #       #data = o_rs #.GetRows.transpose
 #       puts o_rs["alertid"]
 #       
 #       o_rs.close()
 #       
 #     rescue Exception => e 
 #       raise e
 #       puts e.inspect
 #     ensure
 #       o_conn.close()
 #     end
    end
    

end


VFPTableComparator.new.connect