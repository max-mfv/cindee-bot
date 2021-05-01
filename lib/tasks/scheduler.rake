desc "This task is called by the Heroku scheduler add-on"
task :update_status => :environment do
  puts "Updating feed..."
  Fetching.new.run
  puts "done."
end