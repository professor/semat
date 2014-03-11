class UsersController < ApplicationController

  before_filter :authenticate_user!

  def my_teams
    user = User.where(:email => params[:email]).first
    @teams = user.teams.order(:name)
    @essence_versions = EssenceVersion.all
    @default_version = "CMU 1.1"
  end

end
