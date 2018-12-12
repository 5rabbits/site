Chef::Log.info('Running deploy/before_migrate.rb in myapp app...')
rails_env = new_resource.environment['RAILS_ENV']

current_release = release_path
execute 'rake assets:precompile' do
  cwd current_release
  command 'bundle exec rake assets:precompile'
  environment 'RAILS_ENV' => rails_env
end
