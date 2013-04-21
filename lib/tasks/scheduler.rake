desc "This task is called by the Heroku scheduler add-on"
task :reset_daily_views => :environment do
  puts "resetting todays views..."
  Video.update_all(arl_views_today: 0)
  puts "done."
end

task :reset_week_views => :environment do
  puts "resetting week views..."
  Video.update_all(arl_views_week: 0)
  puts "done."
end

task :reset_month_views => :environment do
  puts "resetting months views..."
  Video.update_all(arl_views_month: 0)
  puts "done."
end
