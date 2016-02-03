require 'bundler'
Bundler.require
require 'carrierwave/orm/activerecord'
require_all 'helpers'
require_all 'uploader'
require_all 'models'
require_all 'controllers'
# Dir[Dir.getwd.join('app', 'uploaders', '*.rb')].each { |file| require file }

configure {
  set :server, :puma  
  set :assets_precompile, %w(application.js application.css *.png *.jpg *.svg *.eot *.ttf *.woff)
  set :assets_css_compressor, :sass
  set :session_secret, "Y_W'qTBeVSGE3y?k#R^<*nh,tZ=7]:W*Bf7)+t=9;~w6#x_~TtE*6Nr{n#H+.rN3"
  set :assets_js_compressor, :uglifier
  set :protection, :except => :frame_options
  set :assets_prefix, ['assets']
  set :digest, true
  register Sinatra::AssetPipeline
  register Sinatra::Partial

  if defined?(RailsAssets)
    RailsAssets.load_paths.each do |path|
      settings.sprockets.append_path(path)
    end
  end
}
helpers Helper

class TaskManager < Sinatra::Application
  enable :sessions
  use LoginScreen
  use ProjectController
  use TaskController

  before '/' do
    halt haml :'login/login' unless current_user
  end

  before '/change_password' do
    halt json errors: "You must log in" unless current_user
    halt json errors: "Please send valid attributes" unless params["user"]
  end

  get '/' do
    haml :index
  end 

  post '/' do
    json html: haml(:index, layout: false)
  end 

  post "/change_password" do
    current_user.update_attributes params["user"]
    if current_user.valid?
      json success: true
    else
      json errors: current_user.errors.messages
    end
  end

  run! if app_file == $0
end
