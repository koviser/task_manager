module Helper
  
  def current_user
    @current_user ||=  env['warden'].user
  end

  def current_project
    @current_project ||= Project.find_by_id session['project_id']
  end

  def img_pr(project)
    project.picture.url if project.picture.present?
  end

  def projects
    @projects ||= current_user.try(:projects) || []
  end

  def project_path(project)
    if project
      "/project/#{project.try(:id)}"
    else
      nil
    end
  end

  def tasks(project)
    @tasks ||= Task.priorities.keys.map{|k| [k, project.tasks.send(k)]}.to_h
  end

  def task_path(task)
    if task
      "/task/#{task.try(:id)}"
    else
      nil
    end
  end

  def parse_time(time)
    time.strftime("%Y-%m-%d") if time
  end

end