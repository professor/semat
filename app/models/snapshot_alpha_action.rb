class SnapshotAlphaAction < ActiveRecord::Base

  belongs_to :snapshot_alpha
  belongs_to :action

  def copy_as_new_many_to_many
    return nil if self.action.do_not_copy
    new_many_to_many = self.dup
    new_many_to_many
  end

end
