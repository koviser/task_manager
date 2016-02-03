'use strict'
class Project
  constructor: ()->
    @block = $(".progects")
    @popup = $(".popups .project_form")
    @popup_edit = $(".popups .project_edit")
    @form_c = @popup.find "form.create"

  show: (content)->
    @block.html content

# create class cast
project = new Project()
window.project = project