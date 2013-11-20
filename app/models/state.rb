class State < ActiveRecord::Base

  acts_as_list :column => "order", :scope => [:alpha_id]

  has_many :checklists
  belongs_to :alpha

  def achieved? checklist_ids_hash
    checklists.each do |checklist|
      unless checklist_ids_hash.has_key?(checklist.id)
        return false
      end
    end
    true
  end

end

