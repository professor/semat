class Checklist < ActiveRecord::Base

  acts_as_list :column => "position", :scope => [:state_id]

  belongs_to :state


  def self.add_check(team, checklist, scribe)


    checklist_present = TeamChecklist.where(:team_id => team.id, :checklist_id => checklist.id).first
    if checklist_present.nil?
      checklist_present = TeamChecklist.create(:team_id => team.id, :checklist_id => checklist.id, :scribe_id => scribe.id)
    end
    checklist_present
  end

  def self.remove_check(team, checklist)
    checklist = TeamChecklist.where(:team_id => team.id, :checklist_id => checklist.id).first
    if (checklist)
      result = checklist.destroy
    end
    result
  end


end
