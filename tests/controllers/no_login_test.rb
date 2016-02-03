# # test.rb
require File.expand_path '../../test_helper.rb', __FILE__

class NoLoginTest < MyTest 

  test "get" do
    get "/"
    no_user
    get "/project/#{project1.id}"
    no_user
  end

  test "post app" do
    post "/"
    no_user
    post "/change_password"
    no_user_task
  end

  test "post project" do
    post "/project"
    no_user
    post "/project/#{project1.id}" 
    no_user
  end 

  test "edit project" do 
    patch "/project/#{project1.id}"
    no_user
    put "/project/#{project1.id}"
    no_user
    delete "/project/#{project1.id}"
    no_user
  end

  test "post task" do 
    post "/task"
    no_user_task
    post "/task/#{task1.id}"
    no_user_task
  end
 
  test "edit task" do
    patch "/task/#{task1.id}"
    no_user_task
    put "/task/#{task1.id}"
    no_user_task
    delete "task/#{task1.id}"
    no_user_task
  end
   
end