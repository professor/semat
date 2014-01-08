class State < ActiveRecord::Base

  acts_as_list scope: :alpha

  has_many :checklists, :dependent => :destroy
  belongs_to :alpha

  def self.visible
    where(:visible => true)
  end

  def achieved? checklist_ids_hash
    checklists.each do |checklist|
      unless checklist_ids_hash.has_key?(checklist.id)
        return false
      end
    end
    true
  end

end

