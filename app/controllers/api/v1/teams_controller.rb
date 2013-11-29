class Api::V1::TeamsController < ApplicationController

  def rename
    begin
      team = Team.find(params[:team_id])
      authorize! :rename, team

      result = team.update_attributes(:name => params[:name])

      if result
        @response = true
      else
        @response = "failed"
      end

    rescue ActiveRecord::RecordNotFound => e
      @response = e.message
    end
  end

  def remove_member
    team = Team.find(params[:team_id])
    authorize! :remove_member, team

    remove_user = User.where(:email => params[:email]).first
    if user
      team.members.delete(remove_user)
    end
    #team.save

  end

  def add_member
    team = Team.find(params[:team_id])
    authorize! :add_member, team

    email = params[:email]
    team.add_member_or_invite(email, current_user)
  end

end