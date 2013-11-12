class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, 
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
    default_team = Team.create(:name => "Default", :owner_id => self.id)
    self.teams = [default_team]
    self.save
  end

end
