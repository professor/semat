class AlphasController < ApplicationController

#  before_filter :authenticate_user!


  def index
    @version = EssenceVersion.first
    team_id = session[:team_id]
    if team_id
      @team = Team.find(team_id)
    else
      @team = current_user.teams.first
    end
  end

  def simple_index
    index
  end

end
