module SnapshotDelta

  def delta_from(previous_checklist_ids_hash)
    current_snapshot_hash = self.checklist_ids_hash.clone
    previous_checklist_ids_hash.keys.each do |key|
      current_snapshot_hash.delete(key) { |missing_key| current_snapshot_hash[0 - missing_key] = true }
    end
    current_snapshot_hash
  end

end
