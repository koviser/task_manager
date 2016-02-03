# # test.rb
require File.expand_path '../../test_helper.rb', __FILE__

class LoginScreenTest < MyTest

  test "get" do
    get '/auth/login'
    no_user
    get '/auth/register'
    assert (last_response.body.include? "<div class='authorize'>") and (last_response.body.include? "<div class='register'>")   
  end

  test "post " do
    post "/auth/register"
    has_error
    post "/auth/register", {user: {email: user1.email}}
    has_error
    User.where(email: "register@example.com").delete_all
    post "/auth/register", {user: {email: "register@example.com", password: "123456789", password_confirmation: "123456789"}}
    has_html
    post '/auth/logout'
    has_success
    post '/auth/login'
    has_error
    post '/auth/login', {user: {email: "register@example.com", password: "123456789"}}
    has_html
  end  

end