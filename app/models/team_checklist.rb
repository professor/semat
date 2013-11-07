class TeamChecklist < ActiveRecord::Base

  belongs_to :team
  belongs_to :checklist

end
