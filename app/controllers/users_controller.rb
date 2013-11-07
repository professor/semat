class UsersController < ApplicationController

  before_filter :authenticate_user!

  def my_teams
    user = User.find(params[:email])
    @teams = user.teams
  end

end
