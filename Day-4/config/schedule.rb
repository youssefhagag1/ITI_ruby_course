# config/schedule.rb  –  Whenever gem configuration
# Run:  whenever --update-crontab
#
# Bonus requirement: run articles:remove_over_reported every 5 minutes

every 5.minutes do
  rake "articles:remove_over_reported"
end
