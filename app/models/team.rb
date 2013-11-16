class Team < ActiveRecord::Base

  has_many :team_checklists
  has_many :checklists, :through => :team_checklists, :source => :checklist

  has_many :team_users
  has_many :members, :through => :team_users, :source => :user

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

end
