class Alpha < ActiveRecord::Base
  
  acts_as_list :column => "order"
  has_many :states
  belongs_to :essence_version

end
