class Api::V1::UsersController < ApplicationController

  def my_teams
    user = User.where(:email => params[:email]).first
    @teams = user.teams.order(:name)
  end

end