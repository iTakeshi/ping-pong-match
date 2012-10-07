ssh_options[:forward_agent] = true
ssh_options[:port] = '11122'
default_run_options[:pty] = true

set :scm, :git
set :repository, "git://github.com/iTakeshi/ping-pong-match.git"

set :deploy_via, :remote_cache
set :scm_verbose, true
set :use_sudo, false
set :rails_env, :production

set :application, 'ping-pong'

  puts "\n\e[0;31m Are you REALLY sure you want to deploy to production? \e[0m\n"
  proceed = STDIN.gets[0..0] rescue nil
  exit unless proceed == 'y' || proceed == 'Y'

  set :user, 'itakeshi'
  set :domain, 'ping-pong.itakeshi.net'
  set :port, '11122'
  set :branch, 'master'

  set :deploy_to, "/var/app/rails/#{application}"
  role :web, domain                   # Your HTTP server, Apache/etc
  role :app, domain                   # This may be the same as your `Web` server
  role :db,  domain, :primary => true # This is where Rails migrations will run

namespace :deploy do
  desc "cause Passenger to initiate a restart"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

require 'bundler/capistrano'
load 'deploy/assets'
