'use strict'
class Login
  constructor: ()->
    @block = $(".authorize")
    @header = $("header")
    @login = $(".authorize .login")
    @register = $(".authorize .register")
    @user = $("header .user")
    @change_btn = $("header .change")
    @log_out = $(".log_out")
    @form_l = $(".authorize .login form")
    @form_r = $(".authorize .register form")
    @change_form = $(".change_form")
    @changes = $(".popups .changes")
    @form_c = $(".popups .changes form")

  hide: ->
    @_clear_f()
    @block.addClass "hide"
    @header.removeClass "hide"    

  show: ->
    @_clear_f()
    @header.addClass "hide"
    @block.removeClass "hide"
    project.block.html("")
    link.root()

  change: ->
    @_clear_f()
    @login.toggleClass "hide"
    @register.toggleClass "hide"
    if @login.hasClass "hide"
      link.set_url "/auth/register"
    else
      link.root()

  _clear_f: ->
    helper.clear_form @form_l
    helper.clear_form @form_r

  
# create class cast
login = new Login()
window.login = login