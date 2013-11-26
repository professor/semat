class SnapshotAlpha < ActiveRecord::Base

  belongs_to :snapshot
  belongs_to :alpha

  def copy_as_new_alpha_status
    new_alpha_status = self.clone
    new_alpha_status.scribe_id = nil
    new_alpha_status.action = nil
    new_alpha_status.notes = nil
  end

end
