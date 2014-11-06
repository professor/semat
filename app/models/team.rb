class Team < ActiveRecord::Base

  has_many :team_checklists, :dependent => :destroy
  has_many :checklists, :through => :team_checklists, :source => :checklist

  has_many :team_users, :dependent => :destroy
  has_many :members, :through => :team_users, :source => :user

  has_many :snapshots, -> { order('position ASC') }, :dependent => :destroy

  belongs_to :owner, :class_name => :User
  belongs_to :essence_version

  validates_presence_of :essence_version_id, :name

#  default_scope

  def add_member_or_invite(email, current_user)
    user = User.where(:email => email).first
    if user.nil?
      puts '*** creating user'
      user = User.invite!({:email => email}, current_user)
    end
    puts "*** user email: #{user.email}"
    unless self.members.include?(user)
      self.members << user
    end
  end

  def self.create_default_team(team_name, owner, version_name = 'CMU 1.1')
    default_team = Team.new(:name => team_name, :owner_id => owner.id)
    default_team.essence_version = EssenceVersion.where(:name => version_name).first
    default_team.members = [owner]
    default_team.save
    default_team
  end


  #def checklist_ids_hash
  #  checklists = self.checklists
  #  checklist_ids_hash = Hash.new
  #  checklists.collect { |d| checklist_ids_hash.store(d.id, true) }
  #  checklist_ids_hash
  #end

  def checklist_ids_hash
    latest_snapshot = self.snapshots.last
    checklist_ids_hash = Hash.new
    latest_snapshot.checklists.collect { |d| checklist_ids_hash.store(d.id, true) } if latest_snapshot.present?
    checklist_ids_hash
  end

  def notes_hash
    latest_snapshot = self.snapshots.last
    notes_hash = Hash.new
    latest_snapshot.snapshot_alphas.collect { |d| notes_hash.store(d.alpha_id, d.notes) } if latest_snapshot.present?
    notes_ids_hash
  end


  def find_latest_or_create_new_snapshot_if_older_than_4_hours
    latest_snapshot = self.snapshots.last

    if latest_snapshot.nil?
      current_snapshot = Snapshot.new_with_unknown_state_of_each_alpha(self.essence_version)
      self.snapshots << current_snapshot
    elsif latest_snapshot.created_at < 4.hours.ago
      current_snapshot = latest_snapshot.copy_as_new_snapshot
      self.snapshots << current_snapshot
    else
      current_snapshot = latest_snapshot
    end

    current_snapshot
  end

  def find_latest_or_create_first_snapshot
    latest_snapshot = self.snapshots.last

    if latest_snapshot.nil?
      current_snapshot = Snapshot.new_with_unknown_state_of_each_alpha(self.essence_version)
      self.snapshots << current_snapshot
    else
      current_snapshot = latest_snapshot
    end

    current_snapshot
  end

  def delta_array_of_checklists
    delta = []
    previous_snapshot_hash = {}
    self.snapshots.each do |snapshot|
      current_snapshot_hash = snapshot.delta_from(previous_snapshot_hash)
      # binding.pry
      delta << current_snapshot_hash
      previous_snapshot_hash = snapshot.checklist_ids_hash
    end
    delta
  end

end
