class Team < ActiveRecord::Base

  has_many :team_checklists
  has_many :checklists, :through => :team_checklists, :source => :checklist

  has_many :team_users
  has_many :members, :through => :team_users, :source => :user

  belongs_to :owner, :class_name => :User

#  default_scope

end
