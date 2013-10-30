require 'roo'
#require 'essence_version'
#require '../app/models/alpha'
#require '../app/models/state'
#require '../app/models/checklist'
#
class AlphaCardParser


  def self.import
    s = Roo::Spreadsheet.open("./lib/SEMAT_Alpha_Cards_OMG_1.0.xlsx")
#    s = Roo::Spreadsheet.open("./lib/simple.xlsx")
    @version = EssenceVersion.create(:name => "OMG 1.0")

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
    else
      handle_new_checklist(row)
    end

  end


  def self.handle_new_alpha(row)
    puts "handle_new_alpha     " + row.inspect
    @current_alpha = Alpha.create(:essence_version_id => @version.id, :name => row[0], :concern => row[1], :color => row[2],
                                  :definition => row[3], :description => row[4])
  end

  def self.handle_new_state(row)
    puts "handle_new_state     " + row.inspect
    @current_state = State.create(:alpha_id => @current_alpha.id, :name => row[5])
  end

  def self.handle_new_checklist(row)
    puts "handle_new_checklist " + row.inspect
    Checklist.create(:state_id => @current_state.id, :name => row[6])
  end


end