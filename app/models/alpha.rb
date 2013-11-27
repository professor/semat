class Alpha < ActiveRecord::Base
  
  acts_as_list :column => "order"
  has_many :states
  belongs_to :essence_version


  def index_of_first_unachieved_card(checklist_ids_hash)
    index_of_first_unachieved_card = 0
    self.states.each_with_index do |state, index|
      if state.achieved?(checklist_ids_hash)
        index_of_first_unachieved_card += 1
        break
      end
    end

    index_of_first_unachieved_card + 1
  end

  def first_unachieved_card(checklist_ids_hash)
    first_unachieved_card = nil
    self.states.each_with_index do |state, index|
      if !state.achieved?(checklist_ids_hash)
        first_unachieved_card = state
        break
      end
    end

    first_unachieved_card
  end

end
