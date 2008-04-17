set :application, "leihs2test"
set :repository,  "http://code.zhdk.ch/svn/leihs/trunk"
set :db_config, "/home/rails/leihs2test/database.yml"
set :checkout, :export

set :rails_env, "development"


# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/home/rails/leihs/#{application}"


# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion

role :app, "leihs@webapp.zhdk.ch"
role :web, "leihs@webapp.zhdk.ch"
role :db,  "leihs@webapp.zhdk.ch", :primary => true

task :link_config do
  on_rollback { run "rm #{release_path}/config/database.yml" }
  run "rm #{release_path}/config/database.yml"
  run "ln -s #{db_config} #{release_path}/config/database.yml"
end

task :remove_htaccess do
	# Kill the .htaccess file as we are using mongrel, so this file
	# will only confuse the web server if parsed.

	run "rm #{release_path}/public/.htaccess"
end

task :make_tmp do
	run "mkdir -p #{release_path}/tmp/sessions #{release_path}/tmp/cache"
end


namespace :deploy do
	task :start do
	# we do absolutely nothing here, as we currently aren't
	# using a spinner script or anything of that sort.
	end

	task :restart do
	# dito
	end
end

after "deploy:symlink", :link_config
before "deploy:restart", :remove_htaccess
before "deploy:restart", :make_tmp
