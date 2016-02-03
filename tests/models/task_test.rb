# # test.rb
require File.expand_path '../../test_helper.rb', __FILE__

class TaskTest < MyTest

  test "task free parameters" do
    tk = Task.create()
    assert !tk.save
  end

  test "task no project" do
    tk = Task.create({name: "test_task"})
    assert !tk.save
  end

  test "task no name" do
    tk = Task.create({project: project1})
    assert !tk.save
  end

  test "task create" do
    assert Task.create({project: project1, name: "test_task"})
  end

end