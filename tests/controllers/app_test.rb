# # test.rb
require File.expand_path '../../test_helper.rb', __FILE__

class AppTest < TestLogin
 
  test "url ok" do 
    get "/"
    assert last_response.body.include? "<div class='user'>#{current_user.email}</div>"
    assert last_response.ok?
    post "/"
    assert last_response.ok?
  end  

  test "change_password" do
    post "/change_password"
    assert_equal "{\"errors\":\"Please send valid attributes\"}", last_response.body
    post "/change_password", {user: {password: "123"}}
    has_error
    post "/change_password", {user: {password: "123456789", password_confirmation:"123456789"}}
    has_success    
  end

end

