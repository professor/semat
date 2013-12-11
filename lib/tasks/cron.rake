require 'rubygems'
require 'rake'
require 'fileutils'


desc "task for all cron tab entries"
task :cron do

 puts "---Running task :cron"



  #Run every day
  Rake::Task['semat:admins:email_admins_about_new_users'].invoke
end
