set :application, 'blinky'
set :repo_url, 'git@github.com:bguest/blinky.git'

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploy_to, '/var/www/blinky'
set :scm, :git
#set :scm, :gitcopy
#set :scm, :copy
#set :deploy_via, :remote_cache
set :repository,  "."
set :local_repository, "."
#set :branch, "master"
set :branch, "sequence"
#set :rvm_ruby_string, 'ruby-2.0.0-p247'
#set :rvm_bin_path, "/usr/local/rvm/bin"
#set :git_shallow_clone, 1  # Won't work for branch other than master

# set :format, :pretty
# set :log_level, :debug
#set :pty, true

# set :linked_files, %w{config/database.yml}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 1

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
      execute 'sudo /etc/init.d/thin restart'
      execute 'sudo /etc/init.d/nginx reload'
      execute 'sudo /etc/init.d/nginx restart'
    end
  end
  after :finished, 'deploy:restart'

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'deploy:cleanup'

end
