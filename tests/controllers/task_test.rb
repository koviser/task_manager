# # test.rb
require File.expand_path '../../test_helper.rb', __FILE__

class TaskControllerTest < TestLogin

  test "alien" do
    Task.where(id: 132).destroy_all
    ["132",task_alien.id].each do |id|
      [:patch, :put, :delete].each do |method|
        self.send(method, "/task/#{id}")
        alien_task(method, id)
      end      
    end
  end

  test "create" do
    post "/task"
    has_error
    post "/task", {task: {name: "new task"}}
    has_error
    post "/task", {task: {name: "new task"}}, { 'rack.session' => {"project_id" => project.id } }
    has_html
  end

  test "edit" do
    patch "/task/#{task.id}"
    has_html
    put "/task/#{task.id}", {task: {name: "new task name"}}
    has_html
    delete "/task/#{task.id}"
    has_id
  end  

  test "sortable" do
    post "/tasks/sortable"
    has_correct
    keys = Task.priorities.keys
    #send bad key
    post "/tasks/sortable", {tasks: {bad_keys: ids} }, { 'rack.session' => {"project_id" => project.id } }
    has_correct
    #send alias ids
    post "/tasks/sortable", {tasks: {keys.first => ids_alien} }, { 'rack.session' => {"project_id" => project.id } }
    has_correct
    #send correct and alias ids
    post "/tasks/sortable", {tasks: {keys.first => (ids | ids_alien)} }, { 'rack.session' => {"project_id" => project.id } }
    has_correct
    #correct
    post "/tasks/sortable", {tasks: {keys.first => ids} }, { 'rack.session' => {"project_id" => project.id } }
    has_success
  end
end