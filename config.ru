require './app'

# if using ActiveRecord
use ActiveRecord::ConnectionAdapters::ConnectionManagement

map('/assets') do
  root = Dir.getwd
  sprockets = TaskManager.sprockets
  TaskManager.send :helpers, Sprockets::Helpers
  sprockets.append_path File.join(root, 'assets', 'stylesheets')
  sprockets.append_path File.join(root, 'assets', 'javascripts')
  sprockets.append_path File.join(root, 'assets', 'images')
  Sprockets::Helpers.configure do |config|
    config.environment = sprockets
    config.prefix      = "/"+TaskManager.assets_prefix[0]
    config.public_path = TaskManager.public_folder
    config.digest = false
  end
  run sprockets
end

run TaskManager