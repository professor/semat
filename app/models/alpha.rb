class Alpha < ActiveRecord::Base
  
  acts_as_list :column => "order"
  
end
