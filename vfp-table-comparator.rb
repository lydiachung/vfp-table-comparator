require "rubygems"
require "dbf"

class VFPTableComparator

  def compare(s_tbl_one, s_tbl_two, a_key_cols, a_excl_cols)
    
    
    
    File.open("#{File.basename(s_tbl_two, ".dbf")}.log", 'w') do |o_file|
      
      h_tbl_one_recs = rec_to_hash(s_tbl_one, a_key_cols)
      h_tbl_two_recs = rec_to_hash(s_tbl_two, a_key_cols)
      a_tbl_one_keys = h_tbl_one_recs.keys
      a_tbl_two_keys = h_tbl_two_recs.keys
      a_all_keys = a_tbl_one_keys | a_tbl_two_keys
      a_all_keys.each do |x_key|
        case
        when !h_tbl_one_recs.include?(x_key)
          o_file.write("#{x_key} not found in tbl one\n")
        when !h_tbl_two_recs.include?(x_key)
          o_file.write("#{x_key} not found in tbl two\n")
        else
          o_rec_one = h_tbl_one_recs[x_key]
          o_rec_two = h_tbl_two_recs[x_key]
          s_rec_dif = ""
          o_rec_one.each_pair do |x_key_lcl, x_val_one|
            next if a_excl_cols.include?(x_key_lcl)
            x_val_two = o_rec_two[x_key_lcl]
            s_rec_dif << "#{x_key_lcl} => #{x_val_one} | #{x_val_two}, " unless x_val_one == x_val_two
          end
          o_file.write("[DIFF] #{x_key}: #{s_rec_dif}\n") unless s_rec_dif.empty?
        end
      end
    end
  end
  
  def rec_to_hash(s_tbl_name, a_key_cols)
    h_recs = {}
    o_tbl = DBF::Table.new(s_tbl_name)
    
    o_tbl.each do |o_rec|
      next if o_rec.nil? 
      s_key = ""
      a_key_cols.each do |s_key_col|
        s_key << o_rec[s_key_col] << "|"
      end
      h_recs[s_key] = o_rec.attributes 
    end
    return h_recs
  end
   
end

s_tbl_one = File.join("d:","ltuf","P8","system","alertmsg.dbf")
s_tbl_two = File.join("d:","g8p","P8","system","alertmsg.dbf")
a_key_cols = ["ALERTID"]
a_excl_cols = []

s_tbl_one = File.join("d:","ltuf","P8","system","stdcols.dbf")
s_tbl_two = File.join("d:","g8p","P8","system","stdcols.dbf")
a_key_cols = ["COLUMN"]
a_excl_cols = []

s_tbl_one = File.join("d:","ltuf","P8","system","columns.dbf")
s_tbl_two = File.join("d:","g8p","P8","system","columns.dbf")
a_key_cols = ["TABLEID", "COLUMN"]
a_excl_cols = ["UPTIME","POS"]

VFPTableComparator.new.compare(s_tbl_one, s_tbl_two, a_key_cols, a_excl_cols)
