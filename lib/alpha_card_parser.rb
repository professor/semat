require 'roo'
#require 'essence_version'
#require '../app/models/alpha'
#require '../app/models/state'
#require '../app/models/checklist'
#
class AlphaCardParser


  def self.import(file, version_name)
#    s = Roo::Spreadsheet.open("./lib/SEMAT_Alpha_Cards_OMG_1.0.xlsx")
#    s = Roo::Spreadsheet.open("./lib/SEMAT_Alpha_Cards_Printed_Cards.xlsx")
#    s = Roo::Spreadsheet.open("./lib/simple.xlsx")
#    @version = EssenceVersion.create(:name => "OMG 1.0")
#    @version = EssenceVersion.create(:name => "Printed Cards 1.0")

    s = Roo::Spreadsheet.open(file)
    @version = EssenceVersion.create(:name => version_name)
    @current_alpha = nil
    @current_state = nil

    row_index = 2
    while (row_index < s.last_row)
      puts row_index
      parse_row(s.row(row_index))
      row_index += 1
    end
  end

  def self.parse_row(row)
    return unless row.any?
    if row[0].present?
      handle_new_alpha(row)
    elsif row[5].present?
      handle_new_state(row)
    elsif row[6].present?
      handle_new_checklist(row)
    else
      puts "**** no action done  " + row.inspect
    end

  end


  def self.handle_new_alpha(row)
    puts "handle_new_alpha     " + row.inspect
    @current_alpha = Alpha.create(:essence_version_id => @version.id, :name => row[0].strip, :concern => row[1].strip, :color => row[2].strip,
                                  :definition => row[3].strip, :description => row[4].strip)
  end

  def self.handle_new_state(row)
    puts "handle_new_state     " + row.inspect
    @current_state = State.create(:alpha_id => @current_alpha.id, :name => row[5].strip)
  end

  def self.handle_new_checklist(row)
    puts "handle_new_checklist " + row.inspect
    Checklist.create(:state_id => @current_state.id, :name => row[6].strip)
  end


end