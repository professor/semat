class EssenceVersion < ActiveRecord::Base

  has_many :alphas, -> { order("position ASC") }

  def to_param
    name
  end

end
