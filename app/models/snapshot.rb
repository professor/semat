class Snapshot < ActiveRecord::Base

  acts_as_list scope: :team

  belongs_to :team

  has_many :snapshot_checklists, dependent: :destroy
  has_many :checklists, :through => :snapshot_checklists, :source => :checklist

  has_many :snapshot_alphas, dependent: :destroy
  has_many :status_of_alphas, :through => :snapshot_alphas, :source => :alpha

  def copy_as_new_snapshot
    new_snapshot = self.dup
    new_snapshot.position = nil

    self.snapshot_checklists.each { |checklist| new_snapshot.snapshot_checklists << checklist.dup } if self.snapshot_checklists.present?
    self.snapshot_alphas.each { |alpha_status| new_snapshot.snapshot_alphas << alpha_status.copy_as_new_alpha_status } if self.snapshot_alphas.present?

    new_snapshot
  end

  def self.new_with_unknown_state_of_each_alpha(essence_version)
    snapshot = Snapshot.create()
    essence_version.alphas.each do |alpha|
      SnapshotAlpha.create(:snapshot_id => snapshot.id, :alpha_id => alpha.id, :current_state_id => alpha.states.first.id)
    end
    snapshot
  end

  def self.add_check(team, checklist, scribe)
    snapshot = team.find_latest_or_create_new_snapshot_if_older_than_4_hours

    checklist_present = SnapshotChecklist.where(:snapshot_id => snapshot.id, :checklist_id => checklist.id).first
    if checklist_present.nil?
      checklist_present = SnapshotChecklist.create(:snapshot_id => snapshot.id, :checklist_id => checklist.id, :scribe_id => scribe.id)
    end

    snapshot.update_current_alpha_state(checklist.state.alpha)

    checklist_present
  end

  def self.remove_check(team, checklist)
    snapshot = team.find_latest_or_create_new_snapshot_if_older_than_4_hours

    checklist_present = SnapshotChecklist.where(:snapshot_id => snapshot.id, :checklist_id => checklist.id).first
    if (checklist_present)
      result = checklist_present.destroy
      snapshot.update_current_alpha_state(checklist.state.alpha)
    end

    result
  end

  def update_current_alpha_state(alpha)
    checklist_ids_hash = self.checklist_ids_hash
    state = alpha.last_achieved_card(checklist_ids_hash)

    if state.present?
      logger.info "last_achieved_card is " + state.id.to_s
      alpha_summary = SnapshotAlpha.find_or_create_by(:snapshot_id => self.id, :alpha_id => alpha.id)
      alpha_summary.current_state_id = state.id
      alpha_summary.save
    else
      logger.error "last_unachieved_card is 0 / nil"
    end
  end

  def self.save_actions_old(team, alpha_id, scribe, action_text )
    snapshot = team.find_latest_or_create_new_snapshot_if_older_than_4_hours

    alpha_summary = SnapshotAlpha.find_or_create_by(:snapshot_id => snapshot.id, :alpha_id => alpha_id)

    # remove this is once we set default in migration
    if alpha_summary.actions.blank?
      alpha_summary.actions = action_text
    else
      alpha_summary.actions += "\n" + action_text
    end
    alpha_summary.scribe_id = scribe.id
    alpha_summary.save
  end

  def self.save_actions(team, alpha_id, scribe, action_text )
    snapshot = team.find_latest_or_create_new_snapshot_if_older_than_4_hours

    alpha_summary = SnapshotAlpha.find_or_create_by(:snapshot_id => snapshot.id, :alpha_id => alpha_id)

    action = SnapshotAlphaAction.create(:snapshot_alpha_id => alpha_summary.id, :description => action_text,
                                        :scribe_id => scribe.id, :state => "new")

#    alpha_summary.snapshot_alpha_actions << action
  end

  def self.save_notes(team, alpha_id, scribe, notes_text )
    snapshot = team.find_latest_or_create_new_snapshot_if_older_than_4_hours

    alpha_summary = SnapshotAlpha.find_or_create_by(:snapshot_id => snapshot.id, :alpha_id => alpha_id)

    # remove this is once we set default in migration
    if alpha_summary.notes.blank?
      alpha_summary.notes =  notes_text
    else
      alpha_summary.notes += "\n" + notes_text
    end
    alpha_summary.scribe_id = scribe.id
    alpha_summary.save
  end

  def snapshot_alphas_hash
    alpha_id_to_snapshot_alpha_hash = Hash.new()
    self.snapshot_alphas.each do |snapshot_alpha|
      alpha_id_to_snapshot_alpha_hash[snapshot_alpha.alpha_id] = snapshot_alpha
    end
    alpha_id_to_snapshot_alpha_hash
  end

  def checklist_ids_hash
    checklist_ids_hash = Hash.new
    self.checklists.collect { |d| checklist_ids_hash.store(d.id, true) }
    checklist_ids_hash
  end

  def notes_hash
    notes_hash = Hash.new
    self.snapshot_alphas.collect { |d| notes_hash.store(d.alpha_id, d.notes) }
    notes_hash
  end

  def actions_hash
    actions_hash = Hash.new
#    self.snapshot_alphas.collect { |d| actions_hash.store(d.alpha_id, d.snapshot_alpha_actions.to_a) }
    self.snapshot_alphas.collect { |d| actions_hash.store(d.alpha_id, d.active_actions.to_a) }
    actions_hash
  end

end
