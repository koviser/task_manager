class TaskController < Sinatra::Application

  before "/task" do
    halt json errors: "You must log in" unless current_user
  end

  before "/tasks/sortable" do
    halt json errors: "You must send correct data" unless current_user and current_project.try(:user) == current_user
  end

  before "/task/:id" do |id|
    @task = Task.find_by_id id
    halt json errors: "You must log in" unless current_user
    unless @task and @task.try(:user) == current_user
      halt json errors: "You must send correct data"
    end
  end

  post "/task" do
    task = Task.new params["task"]
    task.project = current_project
    if task.save
      json html: partial("task/one", locals: {task: task}, layout: false), priority: task.priority
    else
      json errors: task.errors.messages
    end
  end

  post "/tasks/sortable" do 
    if params["tasks"]
      begin 
        Task.transaction do
          params["tasks"].each do |k, ids|
            raise ActiveRecord::StatementInvalid, "You must send correct data" if !Task.priorities.keys.include? k 
            Task.includes(:project).where(id: ids).order_by_ids(ids).each_with_index do |task, index|
              raise ActiveRecord::StatementInvalid, "You must send correct data" if task.project.id != current_project.id
              atributes = {
                index: index,
                priority: k
              }
              task.update_attributes atributes
            end#each_with_index
          end#params["tasks"]
        end#Task.transaction
      rescue ActiveRecord::StatementInvalid
        halt json errors: "You must send correct data"
      end#begin
    end
    json success: true
  end

  patch "/task/:id" do |id|
    json html: partial("task/form", locals: {task: @task}, layout: false)
  end

  put "/task/:id" do |id|
    @task.update_attributes params["task"] if params["task"]
    @task.finish = !params["task"].try(:[],"finish").nil?
    if @task.valid?
      @task.save
      json html: partial("task/one", locals: {task: @task}, layout: false), id: @task.id, priority: @task.priority
    else
      json errors: @task.errors.messages
    end
  end

  delete "/task/:id" do |id|
    @task.destroy
    json success: true, id: id
  end

end
