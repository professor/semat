class TeamsController < ApplicationController
  
  before_filter :authenticate_user!

  def new
    @team = Team.new(:owner_id => current_user.id)
  end

  def edit
    @team = Team.new(:owner_id => current_user.id)
  end

  def create
    @team = Team.new(params[:team])

    respond_to do |format|
      if @team.save
        format.html { redirect_to(teams_path, :notice => 'Team was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @team = Team.find(params[:id])
#    authorize! :update, @team

    respond_to do |format|
      if @team.update_attributes(params[:team])
        format.html { redirect_to(teams_path, :notice => notice_msg || 'Team was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def show
    @team = Team.find(params[:id])
    @members = @team.members
  end

  def add_member

  end

  def checklists
    @team = Team.find(params[:id])
    @checked_checklists = @team.checklists
  end
end
