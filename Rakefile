require 'sinatra/asset_pipeline/task.rb'
require './app'
# require your app file first
require 'sinatra/activerecord/rake'

Sinatra::AssetPipeline::Task.define! TaskManager

require 'rake/testtask'
Rake::TestTask.new do |t|
  t.test_files = FileList["tests/**/*_test.rb"]
end