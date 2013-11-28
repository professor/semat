class Api::V1::ProgressController < ApplicationController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }
  def mark
    #Maybe we can remove these finds if saving TeamChecklist fails if the FK's don't exist
    begin
      team = Team.find(params[:team_id])
      checklist = Checklist.find(params[:checklist_id])
      checked = params[:checked]

      if checked == true || checked == "true"
        puts "*** checked"
        result1 = Checklist.add_check(team, checklist, current_user)
        result = Snapshot.add_check(team, checklist, current_user)
        @response = true
      else
        puts "*** unchecked"
        result = Checklist.remove_check(team, checklist)
        result = Snapshot.remove_check(team, checklist)
        @response = true
      end

    rescue ActiveRecord::RecordNotFound => e
      @response = e.message
    end
  end

  def save_actions
    begin
      team = Team.find(params[:team_id])

      Snapshot.save_actions(team, params[:alpha_id], current_user, params[:actions] )

      @response = true

    rescue ActiveRecord::RecordNotFound => e
      @response = e.message
    end
  end

  def save_notes
    begin
      team = Team.find(params[:team_id])

      Snapshot.save_notes(team, params[:alpha_id], current_user, params[:notes] )

      @response = true

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
      @current_alpha_states.store(alpha.id,
                                  alpha.index_of_first_unachieved_card(checklist_ids_hash))
    end
  end

end