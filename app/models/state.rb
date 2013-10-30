class State < ActiveRecord::Base

  acts_as_list :column => "order", :scope => [:alpha_id]

  has_many :checklists
  belongs_to :alpha

end

