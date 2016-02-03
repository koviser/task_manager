if $(".tasks").length > 0
  task.drag()

project.block.on "click", ".tasks a.back", (event)->
  event.preventDefault()
  task.drag_d()
  link.set_url "/"
  helper.ajax
    url: "/"
    callback: (data)->
      project.show data.html

project.block.on "click", ".tasks a.create", (event)->
  event.preventDefault()  
  helper.close_popups()
  task.popup.removeClass "hide"

task.form_c.submit ->
  helper.send_form
    url: "/task"
    element: this
    callback: (data)->
      project.block.find(".tasks ol."+data.priority).prepend data.html

task.popup_edit.on "submit", "form.edit", ->
  helper.send_form
    url: $(this).data "url"
    type: "put"
    element: this
    callback: (data)->
      task = project.block.find(".tasks li.task_"+data.id)
      element = $(task).closest(".castom_info")
      if $(element).data("priority") == data.priority
        html = $.parseHTML(data.html)
        task.html $(html).html()
      else
        task.remove()
        project.block.find(".tasks ol."+data.priority).prepend data.html

project.block.on "click", ".tasks .destroy", ->
  if confirm "Are you sure?"
    element = $(this).closest(".castom_info")
    helper.ajax
      url: $(element).data "url"
      type: "delete"
      callback: (data)->
        project.block.find(".tasks li.task_"+data.id).remove()

project.block.on "click", ".tasks .edit_task", ->
  element = $(this).closest(".castom_info")
  helper.ajax
    url: $(element).data "url"
    type: "patch"
    callback: (data)->      
      helper.close_popups()
      task.popup_edit.removeClass "hide"      
      task.popup_edit.html data.html

project.block.on "click", ".tasks input.task_finish", ->
  element = $(this).closest(".castom_info")
  data = if this.checked
    {task:{finish: true}}
  else
    {task: {}}
  helper.ajax
    url: $(element).data "url"
    type: "put"
    data: data
    callback: (data)->