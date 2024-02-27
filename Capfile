# Load DSL and set up stages
require 'capistrano/setup'

# Load DSL and set up stages
require 'capistrano/setup'

require 'capistrano/scm/git'
# install_plugin Capistrano::SCM::Git

# Include default deployment tasks
require 'capistrano/deploy'

require 'capistrano/rbenv'
require 'capistrano/bundler'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'
require 'capistrano-db-tasks'
require 'capistrano/passenger'
# require 'capistrano/sitemap_generator'
require 'capistrano/nvm'
# require 'whenever/capistrano'

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
