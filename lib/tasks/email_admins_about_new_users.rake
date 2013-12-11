require 'rubygems'
require 'rake'

namespace :semat do
  namespace :admins do
    desc "email_admins_about_new_users"
    task(:email_admins_about_new_users => :environment) do
      User.email_admins_about_new_users
    end
  end
end