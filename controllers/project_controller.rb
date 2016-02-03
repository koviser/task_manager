class ProjectController < Sinatra::Application

  before "/project*" do
    halt haml :index unless current_user
  end

  before "/project/:id" do |id|
    @project = Project.find_by_id id
    unless @project and @project.try(:user) == current_user
      halt json errors: "You must send correct project"
    end
  end
  
  post "/project" do
    project = Project.new params["project"]
    # binding.pry
    project.user = current_user
    if project.save
      json html: partial("projects/one", locals: {project: project}, layout: false)
    else
      json errors: project.errors.messages
    end
  end

  get "/project/:id" do |id|
    session['project_id'] = id
    haml :'projects/tasks', locals: {tasks: tasks(@project)}
  end

  post "/project/:id" do |id|
    session['project_id'] = id
    json html: partial("projects/tasks", locals: {tasks: tasks(@project)}, layout: false)
  end

  patch "/project/:id" do |id|
    json html: partial("shared/project_form", locals: {project: @project}, layout: false)
  end

  put "/project/:id" do |id|
    halt json errors: "You must send correct data" unless params[:project]
    @project.update_attributes params["project"]
    if @project.valid?
      json html: partial("projects/one", locals: {project: @project}, layout: false), id: @project.id
    else
      json errors: @project.errors.messages
    end
  end

  delete "/project/:id" do |id|
    @project.destroy
    json success: true, id: id
  end

end
