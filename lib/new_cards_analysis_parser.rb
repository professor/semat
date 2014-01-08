require 'roo'
require 'csv'
#require 'essence_version'
#require '../app/models/alpha'
#require '../app/models/state'
#require '../app/models/checklist'
#
class NewCardsAnalysisParser


  # NewCardsAnalysisParser.import("./lib/SEMAT_New_Cards_Analysis.xlsx", "./lib/SEMAT_New_Cards_Analysis.tsv")
  # https://discussions.apple.com/message/22948801#22948801 for use with Pages

  def self.import(input_file, output_file)

    s = Roo::Spreadsheet.open(input_file)
    @output = CSV.open(output_file, "wb", col_sep: "\t")

    @current_alpha = nil
    @current_state = nil

    @type = Hash.new
    @severity = Hash.new

    row_index = 2
    while (row_index < s.last_row)
      puts row_index
      parse_row(s.row(row_index))
      row_index += 1
    end

    @output.close

    puts "Type-----------"
    @type.inspect
    puts "Type-----------"
    @type.to_s
    puts "Severity-------"
    @severity.inspect
  end

  def self.parse_row(row)
    return unless row.any?
    if row[0].present? && row[0] == "State"
      handle_new_state(row)
    elsif row[0].present?
      handle_new_alpha(row)
    elsif row[1].present? && row[2].present?
      handle_new_checklist(row)
    else
      puts "**** no action done  " + row.inspect
    end

  end


  def self.handle_new_alpha(row)
    puts "handle_new_alpha     " + row.inspect
    @output << []
    @output << ["Alpha", row[0].strip]
    #@current_alpha = Alpha.create(:essence_version_id => @version.id, :name => row[0].strip, :concern => row[1].strip, :color => row[2].strip,
    #                              :definition => row[3].strip, :description => row[4].strip)
  end

  def self.handle_new_state(row)
    puts "handle_new_state     " + row.inspect
    @output << ["State", row[1].strip]
#    @current_state = State.create(:alpha_id => @current_alpha.id, :name => row[5].strip)
  end

  def self.handle_new_checklist(row)
    puts "handle_new_checklist " + row.inspect
    @output << []
    if row[5].present?
      type = row[5].strip
      @output << ["Type", type]
      if(@type.include?(type))
        @type[type] += 1
      else
        @type[type] = 1
      end
    else
      @output << ["Type", ""]
    end
    if row[6].present?
      severity = row[6].strip
      @output << ["Severity", severity]
      if(@severity.include?(severity))
        @severity[severity] += 1
      else
        @severity[severity] = 1
      end

    else
      @output << ["Severity", ""]
    end
    @output << ["OMG 1.0", row[1].strip]
    @output << ["Short-hand Cards 1.0", row[2].strip]
    @output << ["Proposal", row[4].strip]
    @output << ["Rationale", row[7].strip] if row[7].present?

#    Checklist.create(:state_id => @current_state.id, :name => row[6].strip)
  end


end