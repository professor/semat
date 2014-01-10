class EssenceVersion < ActiveRecord::Base

  has_many :alphas, -> { order("position ASC") }, :dependent => :destroy

  def to_param
    name
  end

  def self.find_by_param(param)
    EssenceVersion.where(:name => param)
  end

end
