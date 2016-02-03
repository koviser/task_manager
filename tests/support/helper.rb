module MyHelper
  def no_user
    assert last_response.body.include? "<div class='authorize'>"
  end

  def no_user_task
    assert_equal "{\"errors\":\"You must log in\"}", last_response.body
  end

  def has_error
    assert last_response.body.include? "{\"errors\""
  end

  def has_id
    assert last_response.body.include? "{\"success\":true,\"id\":"
  end
 
  def has_success
    assert_equal "{\"success\":true}", last_response.body
  end

  def has_html
    assert last_response.body.include? "{\"html\":" 
  end

  def alien_project(method, id)
    assert_equal "{\"errors\":\"You must send correct project\"}", last_response.body, "#{method}:ERROR on id: #{id}"
  end

  def alien_task(method, id)
    assert_equal "{\"errors\":\"You must send correct data\"}", last_response.body, "#{method}:ERROR on id: #{id}"
  end

  def has_correct
     assert_equal "{\"errors\":\"You must send correct data\"}", last_response.body
  end

  def project
    project = current_user.projects.first
    project = Project.create({name: "test_project", user: current_user}) unless project
    project
  end

  def project_alien
    project = user2.projects.first
    project = Project.create({name: "alian project", user: user2}) unless project
    project
  end

  def task
    task = project.tasks.first
    task = Task.create({name: "test task", project: project}) unless task
    task
  end

  def task_alien
    task = project_alien.tasks.first
    task = Task.create({name: "alian task", project: alian_project}) unless task
    task
  end

  def ids
    task
    project.tasks.pluck(:id)
  end
  
  def ids_alien
    ids_alien = project_alien.tasks.pluck(:id)
    if ids_alien.size == 0
      ts = Task.create({name: "test task alien", project: project_alien})
      ids_alien = [ts.id]
    end
    ids_alien
  end

end