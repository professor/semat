class Api::V1::TeamsController < ApplicationController

  def rename
    begin
      team = Team.find(params[:team_id])
      user = User.find(params[:user_id])

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
    user = User.where(:email => params[:email]).first
    if user
      team.members.delete(user)
    end
    #team.save

  end

  def add_member
    team = Team.find(params[:team_id])
    user = User.where(:email => params[:email]).first
    puts "***"
    puts user
    if user.nil?
      puts "*** creating user"
      user = User.create(:email => params[:email])
    end
    team.members << user
    #team.save


  end

end