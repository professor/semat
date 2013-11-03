class Team < ActiveRecord::Base

  has_many :team_checklists
  has_many :checklists, :through => :team_checklists, :source => :checklist

#  default_scope

end
