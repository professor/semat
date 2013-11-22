class Api::V1::UsersController < Api::V1::AlphasController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  before_filter :authenticate_user_from_token!, :except => [:find_or_register]

#  respond_to :json


  def my_teams
    user = User.where(:email => params[:email]).first
    @teams = user.teams.order(:name)
  end

  def find_or_register
    user = User.where(:email => params[:email]).first
    if user.nil?
      user = User.invite!(:email => params[:email])
      @response = "Confirm email sent"
    elsif user.confirmed_at?
      @response = true      
    else
      @response = "Check confirmation email"
    end

    @user_id = user.id
  end

  def login

  end

end