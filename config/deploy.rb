set :application, 'my_app_name'
set :repo_url, 'git@example.com:me/my_repo.git'

set :stages, %w(production staging)
set :default_stage, 'staging'

# Branch options
# Prompts for the branch name (defaults to current branch)
ask :branch, -> { `git rev-parse --abbrev-ref HEAD`.chomp }

# Hardcodes branch to always be master
# This could be overridden in a stage config file


set :log_level, :info

# Apache users with .htaccess files:
# it needs to be added to linked_files so it persists across deploys:
# set :linked_files, %w{.env web/.htaccess}
set :linked_files, %w{.env web/.htaccess}
set :linked_dirs, %w{web/app/uploads}

set :npm_target_path, -> {release_path.join('web/app/themes/mmc/')}
set :npm_flags, '--silent'

set :grunt_tasks, 'build'
set :grunt_file, -> {release_path.join('web/app/themes/mmc/Gruntfile.js')}
set :grunt_target_path, -> {release_path.join('web/app/themes/mmc')}

before 'deploy:update', 'grunt'

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :service, :nginx, :reload
    end
  end
end

# The above restart task is not run by default
# Uncomment the following line to run it on deploys if needed
# after 'deploy:publishing', 'deploy:restart'
