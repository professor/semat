class Team < ActiveRecord::Base

  has_many :team_checklists
  has_many :checklists, :through => :team_checklists, :source => :checklist

  has_many :team_users
  has_many :members, :through => :team_users, :source => :user

  has_many :snapshots

  belongs_to :owner, :class_name => :User

#  default_scope

  def add_member_or_invite(email, current_user)
    user = User.where(:email => email).first
    puts "***"
    puts user
    if user.nil?
      puts "*** creating user"
      user = User.invite!({:email => email}, current_user)
    end
    puts "user email*****"
    puts user.email
    unless self.members.include?(user)
      self.members << user
    end
  end

  def checklist_ids_hash
    checklists = self.checklists
    checklist_ids_hash = Hash.new
    checklists.collect { |d| checklist_ids_hash.store(d.id, true) }
    checklist_ids_hash
  end


  def find_latest_or_create_new_snapshot
    latest_snapshot = self.snapshots.last

    if latest_snapshot.nil?
      current_snapshot = Snapshot.new
      self.snapshots << current_snapshot
    elsif latest_snapshot.created_at < 4.hours.ago
      current_snapshot = latest_snapshot.copy_as_new_snapshot
      self.snapshots << current_snapshot
    else
      current_snapshot = latest_snapshot
    end

    current_snapshot
  end


end
