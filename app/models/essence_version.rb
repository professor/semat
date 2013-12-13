class EssenceVersion < ActiveRecord::Base

  has_many :alphas, -> { order("position ASC") }


end
