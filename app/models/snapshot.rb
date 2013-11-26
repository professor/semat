class Snapshot < ActiveRecord::Base

  acts_as_list :column => "order"
  belongs_to :team

  has_many :snapshot_checklists
  has_many :checklists, :through => :snapshot_checklists, :source => :checklist

  has_many :snapshot_alphas
  has_many :status_of_alphas, :through => :snapshot_alphas, :source => :alpha

  def copy_as_new_snapshot
    new_snapshot = self.dup
    new_snapshot.order = nil

    self.snapshot_checklists.each { |checklist| new_snapshot.snapshot_checklists << checklist.dup } if self.snapshot_checklists.present?
#    self.snapshot_alphas.each { |alpha_status| new_snapshot.snapshot_alphas << checklist.copy_as_new_alpha_status } if self.snapshot_alphas.present?

    new_snapshot
  end


  def self.add_check(team, checklist, scribe)
    snapshot = team.find_latest_or_create_new_snapshot

    checklist_present = SnapshotChecklist.where(:snapshot_id => snapshot.id, :checklist_id => checklist.id).first
    if checklist_present.nil?
      checklist_present = SnapshotChecklist.create(:snapshot_id => snapshot.id, :checklist_id => checklist.id, :scribe_id => scribe.id)
    end

    #snapshot.update_current_alpha_state(checklist.state.alpha)

    checklist_present
  end

  def self.remove_check(team, checklist)
    snapshot = team.find_latest_or_create_new_snapshot

    checklist = SnapshotChecklist.where(:snapshot_id => snapshot.id, :checklist_id => checklist.id).first
    if (checklist)
      result = checklist.destroy
    end
    result
  end

  #def update_current_alpha_state(alpha)
  #  checklist_ids_hash = self.team.checklist_ids_hash
  #    alpha.first_unachieved_card(checklist_ids_hash)
  #
  #  SnapshotAlpha.where()
  #  snapshot_alphas
  #
  #end

  def self.save_actions(team, alpha_id, scribe, action_text )
    snapshot = team.find_latest_or_create_new_snapshot


    alpha_summary_present = SnapshotAlpha.find_or_create_by(:snapshot_id => snapshot.id, :alpha_id => alpha_id)
    #
    #alpha_summary_present = SnapshotAlpha.where(:snapshot_id => snapshot.id, :alpha_id => alpha_id).first
    #if alpha_summary_present.nil?
    #  alpha_summary_present = SnapshotAlpha.create(:snapshot_id => snapshot.id, :alpha_id => alpha_id, :scribe_id => scribe.id)
    #end

    # remove this is once we set default in migration
    if alpha_summary_present.actions.nil?
      alpha_summary_present.actions = action_text
    else
      alpha_summary_present.actions += action_text
    end
    alpha_summary_present.scribe_id = scribe.id
    alpha_summary_present.save
  end

  def self.save_notes(team, alpha_id, scribe, notes_text )
    snapshot = team.find_latest_or_create_new_snapshot

    alpha_summary_present = SnapshotAlpha.find_or_create_by(:snapshot_id => snapshot.id, :alpha_id => alpha_id)
    #
    #alpha_summary_present = SnapshotAlpha.where(:snapshot_id => snapshot.id, :alpha_id => alpha_id).first
    #if alpha_summary_present.nil?
    #  alpha_summary_present = SnapshotAlpha.create(:snapshot_id => snapshot.id, :alpha_id => alpha_id, :scribe_id => scribe.id)
    #end

    # remove this is once we set default in migration
    if alpha_summary_present.notes.nil?
      alpha_summary_present.notes =  notes_text
    else
      alpha_summary_present.notes += notes_text
    end
    alpha_summary_present.scribe_id = scribe.id
    alpha_summary_present.save
  end


end
