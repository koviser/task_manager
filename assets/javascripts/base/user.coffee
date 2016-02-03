login.form_l.submit ->
  helper.send_form
    url: "/auth/login"
    element: this
    callback: (data)->
      login.hide()
      login.user.text data.user
      project.show data.html

login.form_r.submit ->
  helper.send_form
    url: "/auth/register"
    element: this
    callback: (data)->
      login.hide()   
      login.user.text data.user   
      login.change()
      project.show data.html

login.form_c.submit ->
  helper.send_form
    url: "/change_password"
    element: this
    callback: (data)->
      login.changes.addClass "hide"

login.change_btn.click (event)->
  event.preventDefault()
  helper.close_popups()
  login.changes.removeClass "hide"


login.change_form.click ->
  event.preventDefault()
  login.change()


login.log_out.click (event)->
  event.preventDefault()  
  task.drag_d()
  helper.ajax
    url: "/auth/logout"
    callback: ->
      login.show()
