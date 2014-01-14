class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, #:confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :put_user_on_default_team

  has_many :team_users
  has_many :teams, :through => :team_users, :source => :team

  def to_param
    email
  end

  def self.find_by_param(param)
    puts "****" + param
    if param.to_i == 0 #This is a string
      User.where(:email => param)
    else #This is a number
      User.where(param)
    end
  end

  def put_user_on_default_team
    default_team = Team.create_default_team("Sample", self)
#    default_team = Team.create(:name => "Sample", :owner_id => self.id)
#    self.teams = [default_team]
#    self.save
  end

  #def self.today_new_users
  #    where("created_at >= ?", Time.zone.now.beginning_of_day)
  #end

  def self.yesterday_new_users
    where("created_at >= ?", Date.yesterday)
  end

  def self.email_admins_about_new_user
    users = User.yesterday_new_users
    AdminMailer.new_users(users).deliver if users.size > 0
  end

  before_save :ensure_authentication_token

  #source: https://gist.github.com/josevalim/fb706b1e933ef01e4fb6
  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  private

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end

#  # Source: http://stackoverflow.com/questions/6052376/devise-invitable-confirm-after-invitation
#  # devise confirm! method overriden
#  def confirm!
#    welcome_message
#    super
#  end
#    # devise_invitable accept_invitation! method overriden
#  def accept_invitation!
#    self.confirm!
#    super
#  end
#
#  #  # devise_invitable invite! method overriden
#  def invite!
#    super
#    self.confirmed_at = nil
#    self.save
#  end
#
#private
#
#  def welcome_message
#    UserMailer.welcome_message(self).deliver
#  end

end
