class SnapshotAlpha < ActiveRecord::Base

  belongs_to :snapshot
  belongs_to :alpha
  belongs_to :current_state, :class_name => State

  has_many :snapshot_alpha_actions

  def active_actions
    actions = SnapshotAlphaAction.arel_table
    snapshot_alpha_actions.where(actions[:state].eq('new').or(actions[:state].eq('copied')))
  end

  def copy_as_new_alpha_status
    new_alpha_status = self.dup
    new_alpha_status.scribe_id = nil
    new_alpha_status.notes = nil

    self.snapshot_alpha_actions.each { |action|
      new_action = action.copy_as_new_alpha_action
      new_alpha_status.snapshot_alpha_actions << new_action unless new_action.nil?
    } if self.snapshot_alpha_actions.present?

    new_alpha_status
  end

end
