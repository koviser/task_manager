# # test.rb
require File.expand_path '../../test_helper.rb', __FILE__

class ProjectControllerTest < TestLogin

  test "alien" do
    Project.where(id: 132).destroy_all
    ["132",project_alien.id].each do |id|
      [:get, :post, :patch, :put, :delete].each do |method|
        self.send(method, "/project/#{id}")
        alien_project(method, id)
      end      
    end
  end

  test "get" do 
    project = current_user.projects.first
    get "/project/#{project.id}"
    assert last_response.body.include? "<h1>#{project.name}</h1>"
  end

  test "post" do
    post "/project"
    has_error
    post "/project", {project: {name: "test_project"}}
    has_html
    post "/project/#{project.id}"
    has_html
  end

  test "edit" do
    patch "/project/#{project.id}"
    has_html
    put "/project/#{project.id}"
    has_correct
    put "/project/#{project.id}", {project: {name: "new name of project"}}
    has_html   
    delete "/project/#{project.id}"
    has_id 
  end

end