class SnapshotChecklist < ActiveRecord::Base

  belongs_to :snapshot
  belongs_to :checklist

end
