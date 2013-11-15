class Api::V1::UsersController < ApplicationController

  def my_teams
    user = User.where(:email => params[:email]).first
    @teams = user.teams.order(:name)
  end

  def find_or_register
    user = User.where(:email => params[:email]).first
    if user.nil?
      user = User.invite!(:email => params[:email])
    end

    @response = user.id
  end

end