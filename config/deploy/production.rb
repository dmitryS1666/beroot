# frozen_string_literal: true

server 'beroot.ru', user: 'deploy', roles: %w[app web db], port: 22

set :rails_env, 'production'
set :branch, 'master'
