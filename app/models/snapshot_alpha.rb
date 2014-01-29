class SnapshotAlpha < ActiveRecord::Base

  belongs_to :snapshot
  belongs_to :alpha
  belongs_to :current_state, :class_name => State

  has_many :snapshot_alpha_actions
  has_many :actions, :through => :snapshot_alpha_actions, :source => :action

  def active_actions
    #actions = Action.arel_table
    #snapshot_alpha_actions.where(actions[:state].eq('new').or(actions[:state].eq('copied')))
    actions.where(:state => "new")
  end

  def copy_as_new_alpha_status
    new_alpha_status = self.dup
    new_alpha_status.scribe_id = nil
    new_alpha_status.notes = nil

    #self.snapshot_alpha_actions.each { |action|
    #  new_action = action.copy_as_new_alpha_action
    #  new_alpha_status.snapshot_alpha_actions << new_action unless new_action.nil?
    #} if self.snapshot_alpha_actions.present?


    self.snapshot_alpha_actions.each { |snapshot_alpha_action|
      if snapshot_alpha_action.action.state == "new"
          new_many_to_many = snapshot_alpha_action.copy_as_new_many_to_many
          new_alpha_status.snapshot_alpha_actions << new_many_to_many unless new_many_to_many.nil?
      end
    } if self.snapshot_alpha_actions.present?

    new_alpha_status
  end

end
