# frozen_string_literal: true

server 'agromaster.dsml.ru', user: 'deploy', roles: %w[app web db], port: 50022
# server '178.121.164.110', user: 'deploy', roles: %w[app web db], port: 50022

set :rails_env, 'production'
set :branch, 'master'
