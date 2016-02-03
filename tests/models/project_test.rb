# test.rb
require File.expand_path '../../test_helper.rb', __FILE__

class ProjectTest < MyTest

  test "free parameters" do
    pr = Project.new()
    assert !pr.save 
  end

  test "no user" do
    pr = Project.create({name: "test_project"})
    assert !pr.save 
  end

  test "no name" do
    pr = Project.create({user: user1})
    assert !pr.save 
  end

  test "project create" do
    assert Project.create({user: user1, name: "test_project"})
  end

end