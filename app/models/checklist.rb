class Checklist < ActiveRecord::Base
  
  acts_as_list :column => "order", :scope => [:state_id]

  belongs_to :state

end
