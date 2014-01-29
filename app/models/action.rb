class Action < ActiveRecord::Base

  belongs_to :snapshot_alpha
  belongs_to :team  # This is to make analysis easier, note this column is redundant with snapshot_alpha.snapshot.team
  belongs_to :alpha # This is to make analysis easier, note this column is redundant with snapshot_alpha.alpha

#  belongs_to :snapshot_alpha_action #parent

  #state:  new, copied, done, deleted

  def active
    where(:state => "new")
    #actions = Action.arel_table
    #where(actions[:state].eq('new').or(actions[:state].eq('copied')))
  end


  def do_not_copy
    state == "done" || state == "deleted"
  end

  def delete
    self.state = "delete"
    self.save
  end

  def mark_done
    self.state = "done"
    self.save
  end

  def mark_deleted
    self.state = "deleted"
    self.save
  end

  #def copy_as_new_alpha_action
  #  return nil if self.do_not_copy
  #  new_alpha_action = self.dup
  #  new_alpha_action.snapshot_alpha_action_id = self.id
  #  new_alpha_action.state = "copied"
  #  new_alpha_action.scribe_id = nil
  #  new_alpha_action
  #end

end
