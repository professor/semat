class SnapshotAlpha < ActiveRecord::Base

  belongs_to :snapshot
  belongs_to :alpha
  belongs_to :current_state, :class_name => State

  def copy_as_new_alpha_status
    new_alpha_status = self.dup
    new_alpha_status.scribe_id = nil
    new_alpha_status.actions = nil
    new_alpha_status.notes = nil
    new_alpha_status
  end

end
