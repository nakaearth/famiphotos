require 'rvm1/capistrano3'
require 'whenever/capistrano'

# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'famiphotos'
set :repo_url, 'git@github.com:nakaearth/famiphotos.git'
set :deploy_to,  '/home/vagrant'
set :keep_releases,  5

set :rvm_type, :system
set :rvm1_ruby_version, '2.3.0'

set :linked_dirs, %w{bin log tmp/backup tmp/pids tmp/cache tmp/sockets vendor/bundle}
set :unicorn_pid, "#{shared_path}/tmp/pids/unicorn.pid"
set :bundle_jobs, 4
set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :app do
  task :update_rvm_key do
    on roles(:app) do
      execute "gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3"
    end
  end
end
before "rvm1:install:rvm", "app:update_rvm_key"

before 'deploy',  'rvm1:install:rvm'
before 'deploy',  'rvm1:install:gems'

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end
