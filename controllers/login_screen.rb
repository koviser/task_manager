class LoginScreen < Sinatra::Application

  use Warden::Manager do |config|
    config.serialize_into_session{|user| user.id }
    config.serialize_from_session{|id| User.find_by_id(id) }
    config.scope_defaults :default,
      strategies: [:password],
      action: 'auth/unauthenticated'
    config.failure_app = self
  end

  Warden::Manager.before_failure do |env,opts|
    env['REQUEST_METHOD'] = 'POST'
  end

  get '/auth/login' do    
    redirect "/" if current_user
    haml :index
  end

  get '/auth/register' do
    @register = true
    haml ""
  end

  post '/auth/register' do
    user = User.create params["user"]
    if user.valid?
      json html: haml(:index, layout: false), user: current_user.email if env['warden'].authenticate!
    else
      json errors: user.errors.messages
    end
  end
  
  post '/auth/login' do 
    json html: haml(:index, layout: false), user: current_user.email if env['warden'].authenticate!
  end

  post '/auth/logout' do
    env['warden'].raw_session.inspect
    env['warden'].logout
    json success: true
  end

  post '/auth/unauthenticated' do
    session[:return_to] = env['warden.options'][:attempted_path]
    json errors: "You must log in"
  end
end
