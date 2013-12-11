class AdminMailer < ActionMailer::Base
  default from: "semat.tool@sv.cmu.edu"

  def new_users(users)
    @users = users
    mail(to: "todd.sedano@sv.cmu.edu",
         subject: "#{users.size} new user account(s) created")
  end

end
