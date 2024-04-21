set :output, "log/cron.log"
set :bundle_command, "/home/u/.rbenv/shims/bundle exec"

every 1.day, at: '23:30 pm' do
  rake 'update_products:update_db'
end
