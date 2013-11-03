class TeamsController < ApplicationController
  def members
  end

  def checklists
    @team = Team.find(params[:id])
    @checked_checklists = @team.checklists
  end
end
