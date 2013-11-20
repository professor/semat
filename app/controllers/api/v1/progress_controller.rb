class Api::V1::ProgressController < ApplicationController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }
  def mark
    #Maybe we can remove these finds if saving TeamChecklist fails if the FK's don't exist
    begin
      team = Team.find(params[:team_id])
      checklist = Checklist.find(params[:checklist_id])
      user = User.find(params[:user_id])
      checked = params[:checked]

      if checked == "true"
        puts "*** checked"
          checklist_present = TeamChecklist.where(:team_id => team.id, :checklist_id => checklist.id).first
          if checklist_present.nil?
            checklist = TeamChecklist.create(:team_id => team.id, :checklist_id => checklist.id, :scribe_id => user.id)
            @response = true
          else
            @response = "warning - already present"
          end
      else
        puts "*** unchecked"
        checklist = TeamChecklist.where(:team_id => team.id, :checklist_id => checklist.id).first
        if (checklist)
          checklist.destroy
          @response = true
        end
      end

    rescue ActiveRecord::RecordNotFound => e
      @response = e.message
    end
  end

  # http://localhost:3000/api/v1/progress/1.json
  def show
    team = Team.find(params[:team_id])
    checklists = team.checklists
    @checklists_ids = checklists.collect { |d| d.id }
  end

  # localhost:3000/api/v1/progress/1/current_alpha_states.json
  # returns a hash of alpha to current card index
  #
  def current_alpha_states
    team = Team.find(params[:team_id])
    version = EssenceVersion.first
    alphas = version.alphas
    checklist_ids_hash = team.checklist_ids_hash

    @current_alpha_states = Hash.new()

    alphas.each do |alpha|
      index_of_first_unachieved_card = 0
      alpha.states.each_with_index do |state, index|
        if state.achieved?(checklist_ids_hash)
          index_of_first_unachieved_card += 1
          break
        end
      end
      @current_alpha_states.store(alpha.id, index_of_first_unachieved_card + 1)
    end
  end

end