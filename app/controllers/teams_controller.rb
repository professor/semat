class TeamsController < ApplicationController
  
  before_filter :authenticate_user!

  def new
    @team = Team.create_default_team("Rename", current_user, params[:version_name])
    if @team
      session[:team_id] = @team.id
      redirect_to(edit_team_path(@team), :notice => 'Team was successfully created.')
    else
      redirect_to(root_path, :error => 'Unable to add a new team.')
    end
  end

  def edit
    @team = Team.find(params[:id].to_i)
    authorize! :update, @team
    @members = @team.members
  end

  #def create
  #  @team = Team.new(params[:team])
  #
  #  respond_to do |format|
  #    if @team.save
  #      format.html { redirect_to(teams_path, :notice => 'Team was successfully created.') }
  #    else
  #      format.html { render :action => "new" }
  #    end
  #  end
  #end

#  def update
#    @team = Team.find(params[:id])
##    authorize! :update, @team
#
#    respond_to do |format|
#      if @team.update_attributes(params[:team])
#        format.html { redirect_to(teams_path, :notice => notice_msg || 'Team was successfully updated.') }
#      else
#        format.html { render :action => "edit" }
#      end
#    end
#  end

  def show
    @team = Team.find(params[:id].to_i)
    authorize! :read, @team
    @snapshot = @team.find_latest_or_create_first_snapshot
  end

  def mass_invite
    team = Team.find(params[:team_id].to_i)
    authorize! :update, team
    mass_invite = params[:mass_invite]
    mass_invite.split(",").each do |email|
      team.add_member_or_invite(email, current_user) if email.present?
    end

    redirect_to team_path(team)
  end

  def checklists
    @team = Team.find(params[:id].to_i)
    authorize! :read, @team
    @checked_checklists = @team.checklists
  end

  def snapshot_history_first
    @team = Team.find(params[:id].to_i)
    authorize! :read, @team
    @essence_version = @team.essence_version

    @snapshots = []
    @snapshot_history = []
    @team.snapshots.reverse_each do |snapshot|
      @snapshots << snapshot
      @snapshot_history = snapshot.snapshot_alphas_hash
    end

  end

  def snapshot_history
    @team = Team.find(params[:id].to_i)
    authorize! :read, @team
    @snapshot_history = Snapshot.history(@team)
    @snapshots = @team.snapshots.reverse

  end

  def snapshot_export
    @team = Team.find(params[:id].to_i)
    authorize! :read, @team
    temp_file_path = File.expand_path("#{Rails.root}/tmp/#{Process.pid}_") + "export.xls"
    Snapshot.export_history_to_spreadsheet(@team, temp_file_path)
    flash[:notice] = "snapshot history was exported to " + temp_file_path
    send_file(temp_file_path, :filename => "Snapshots_#{@team.name.parameterize}.xls")
  end


end
