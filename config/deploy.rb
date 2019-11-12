# frozen_string_literal: true

# config valid for current version and patch releases of Capistrano
lock '~> 3.11.1'

set :application, 'hacktoberfest'
set :repo_url, 'git@github.com:raise-dev/hacktoberfest.git'

# Ask which branch to deploy
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/deploy/hacktoberfest'

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log",
# color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets",
# "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before
# first deploy.
# set :ssh_options, verify_host_key: :secure

# Options for capistrano-bundler
# See: https://github.com/capistrano/bundler
append :linked_dirs, '.bundle', 'tmp/pids', 'tmp/sockets', 'log'

# Options for capistrano-rails
# See: https://github.com/capistrano/rails
set :migration_role, :app
set :assets_roles, :app

# Options for capistrano-dotenv
# See: https://github.com/capistrano/bundler
append :linked_files, '.env'
before 'bundler:map_bins', 'dotenv:hook'
set :env_file, ".env.#{fetch(:stage)}"
set :dotenv_hook_commands, %w(bundle rake rails sidekiq sidekiqctl puma pumactl)

namespace :dotenv do
  desc 'Upload dotenv config .env.[staging|production]'
  task :config do
    invoke 'dotenv:read'
    invoke 'dotenv:setup'
    invoke 'sidekiq:restart'
    invoke 'puma:restart'
  end
end

# Shared options for capistrano/puma
# See: https://github.com/seuros/capistrano-puma
set :puma_nginx, :app
# Preload app must be false in order to do phased restarts
set :puma_preload_app, false
set :puma_init_active_record, false
set :puma_control_app, false
set :puma_bind, 'unix:///home/deploy/hacktoberfest/shared/tmp/sockets/puma.sock?backlog=4096'
# Worker and thread count options in stage specific config
# set :puma_threads, [0, 16]
# set :puma_workers, 8
after 'puma:config', 'puma:restart'

namespace :nginx do
  %w[restart start stop].map do |command|
    desc "#{command} nginx"
    task command do
      on roles fetch(:puma_role) do
        execute :sudo, :service, :nginx, command
      end
    end
  end
end

after 'puma:nginx_config', 'nginx:restart'

# Shared options for capistrano/sidekiq
# See: https://github.com/seuros/capistrano-sidekiq
set :sidekiq_roles, :job
# Worker and thread count options in stage specific config
# set :sidekiq_processes, 8
# set :sidekiq_concurrency, 10
