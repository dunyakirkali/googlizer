namespace :googlize do
  desc "Googlize all active users"
  task :all_users => :environment do
    User.googlize
  end
end