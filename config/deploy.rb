# frozen_string_literal: true

# config valid only for current version of Capistrano
require 'capistrano-db-tasks'

set :application, "agromaster"
set :repo_url, "git@git.dsml.ru:dsml/agromaster.git"

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/deploy/projects/agromaster'

# Default value for :linked_files is []
# append
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# append
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'storage')

# Default value for keep_releases is 5
set :keep_releases, 5

set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:production)}" }

set :ssh_options, {
  keys: %w(~/.ssh/new_key),
  forward_agent: false,
#   port: '22',
  user_known_hosts_file: '/dev/null'
}

# set :ssh_options, forward_agent: false

set :rbenv_type, :user
set :rbenv_ruby, '3.1.2'

# set :ssh_options, {verify_host_key: :never}
# set :ssh_options, { user_known_hosts_file: '/dev/null', forward_agent: false }

set :assets_dir, %w[public/system]
set :local_assets_dir, 'public'

set :nvm_type, :user
set :nvm_node, 'v21.5.0'
set :nvm_map_bins, %w[node npm rake]
set :assets_dir, %w[public/uploads]
set :local_assets_dir, %w[public/uploads]

# namespace :deploy do
#
#   after :restart, :clear_cache do
#     on roles(:web), in: :groups, limit: 3, wait: 10 do
#       # Here we can do anything such as:
#       # within release_path do
#       #   execute :rake, 'cache:clear'
#       # end
#     end
#   end
#
# end

namespace :deploy do
  after :restart, :clear_cache do
    on roles(:all) do
      within release_path do
        # execute :bundle, :exec, 'rails', 'db:schema:load', 'RAILS_ENV=production', 'DISABLE_DATABASE_ENVIRONMENT_CHECK=1'
        # execute :bundle, :exec, 'rails', 'db:migrate', 'RAILS_ENV=production', 'DISABLE_DATABASE_ENVIRONMENT_CHECK=1'
        # execute :bundle, :exec, 'rails', 'db:seed', 'RAILS_ENV=production', 'DISABLE_DATABASE_ENVIRONMENT_CHECK=1'
      end
    end
  end
end

# namespace :db do
#   desc 'Resets DB without create/drop'
#   task :reset do
#     on primary :db do
#       within release_path do
#         execute :rake, 'db:drop', 'RAILS_ENV=production', 'DISABLE_DATABASE_ENVIRONMENT_CHECK=1'
#         execute :rake, 'db:create', 'RAILS_ENV=production', 'DISABLE_DATABASE_ENVIRONMENT_CHECK=1'
#         execute :rake, 'db:migrate', 'RAILS_ENV=production', 'DISABLE_DATABASE_ENVIRONMENT_CHECK=1'
#         execute :rake, 'db:seed', 'RAILS_ENV=production', 'DISABLE_DATABASE_ENVIRONMENT_CHECK=1'
#       end
#     end
#   end
# end