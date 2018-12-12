Chef::Log.info('Running deploy/before_migrate.rb in myapp app...')
rails_env = new_resource.environment['RAILS_ENV']
deploy = new_resource.params[:deploy_data]
current_release = release_path

env = {
  SECRET_KEY_BASE: new_resource.environment['SECRET_KEY_BASE'],
  BLOG: new_resource.environment['BLOG']
}

file '.env' do
  cwd current_release
  group deploy[:group]
  owner deploy[:user]
  mode 0775
  action :create
  content env.map { |k, v| "#{k}=#{v}" }.join("\n")
end


execute 'rake assets:precompile' do
  cwd current_release
  command 'bundle exec rake assets:precompile'
  environment 'RAILS_ENV' => rails_env
end
