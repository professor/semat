class AlphasController < ApplicationController

#  before_filter :authenticate_user!


  def index
    @version = EssenceVersion.first
    @teams = current_user.teams

    team_id = params[:team_id]
    if team_id
      @team = Team.find(team_id)
    else
      @team = current_user.teams.first
    end



    checklists = @team.checklists
    @checklist_ids_hash = Hash.new
    checklists.collect { |d| @checklist_ids_hash.store(d.id, true) }
    puts "***"
    puts @checklist_ids_hash
  end

  def simple_index
    index
  end

end
