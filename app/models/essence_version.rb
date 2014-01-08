class EssenceVersion < ActiveRecord::Base

  has_many :alphas, -> { order("position ASC") }, :dependent => :destroy

  def to_param
    name
  end

end
