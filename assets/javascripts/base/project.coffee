project.block.on "click", "a.create_project", (event)->
  event.preventDefault()
  helper.close_popups()
  helper.clear_form project.form_c
  project.popup.removeClass "hide"

project.block.on "click", "a.got_to_task", (event)->
  event.preventDefault()
  link.set_url $(this).data "url"
  helper.ajax
    url: $(this).data "url"
    callback: (data)->
      project.show data.html
      task.drag()

project.popup_edit.on "submit", "form.edit", ->
  helper.send_form
    url: $(this).data "url"
    type: "put"
    element: this
    callback: (data)->
      pr = project.block.find ".project_"+data.id
      html = $.parseHTML(data.html)
      pr.html $(html).html()

project.block.on "click", ".project .edit", ->
  helper.ajax
    url: $(this).data "url"
    type: "patch"
    callback: (data)->
      helper.close_popups()
      project.popup_edit.removeClass "hide"
      project.popup_edit.html data.html

project.block.on "click", ".project .destroy", ->
  if confirm "Are you sure?"
    helper.ajax
      url: $(this).data "url"
      type: "delete"
      callback: (data)->
        project.block.find(".project_"+data.id).remove()

project.form_c.submit ->
  helper.send_form
    url: "/project"
    element: this
    callback: (data)->
      project.block.prepend data.html