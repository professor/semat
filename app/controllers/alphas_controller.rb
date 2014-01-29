class AlphasController < ApplicationController

 before_filter :authenticate_user!


  def index
#    @version = EssenceVersion.first
    @teams = current_user.teams

    team_id = params[:team_id]
    if team_id
      @team = Team.find(team_id)
      @version = @team.essence_version
    else
      @team = current_user.teams.first
      @version = @team.essence_version
    end


#    latest_snapshot = @team.find_latest_or_create_new_snapshot_if_older_than_4_hours
   latest_snapshot = @team.find_latest_or_create_first_snapshot

    @checklist_ids_hash = latest_snapshot.checklist_ids_hash
    @notes_hash = latest_snapshot.notes_hash
    @actions_hash = latest_snapshot.actions_hash

    puts "***"
    puts @checklist_ids_hash
  end

  def simple_index
    index
  end

end
