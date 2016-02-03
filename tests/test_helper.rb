# test_helper.rb
ENV['RACK_ENV'] ||= 'test'

require 'rack/test'
require 'active_record'
require 'active_record/fixtures'
require 'test/unit'
require File.expand_path '../support/users.rb', __FILE__
require File.expand_path '../support/projects.rb', __FILE__
require File.expand_path '../support/tasks.rb', __FILE__
require File.expand_path '../support/helper.rb', __FILE__
require File.expand_path '../../app.rb', __FILE__
ActiveRecord::Base.establish_connection(:test)

class MyTest < Test::Unit::TestCase
  include Users
  include Projects
  include Tasks
  include MyHelper
  include Rack::Test::Methods  

  def app
    TaskManager
  end

  # undefined method `[]' for nil:NilClass setup_fixture_accessors, прийшов пізно і легше було написати власний костиль, аніжправити active record

  # include ActiveRecord::TestFixtures
  # include ActiveRecord::TestFixtures::ClassMethods
  # self.fixture_path = File.expand_path("../fixtures", __FILE__)
  # self.use_transactional_fixtures = true
  # self.use_instantiated_fixtures  = false
  # fixtures :users
  # fixtures :projects
  # fixtures :tasks 
end

class TestLogin < MyTest  

  def current_user_session
    get '/', {}, { 'rack.session' => {"warden.user.default.key" => user1.id } }
  end
  
  def current_user
    user1
  end
  
  def setup
    current_user_session
  end
end
