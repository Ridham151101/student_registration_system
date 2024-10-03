# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"

set :environment, "development"


every 1.day, at: '12:28 pm' do
  rake "users:send_daily_greetings"
end

every 1.day, at: '12:00 am' do
  rake "users:send_birthday_greetings"
end
