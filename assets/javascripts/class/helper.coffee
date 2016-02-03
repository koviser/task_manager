'use strict'
class Helper
  constructor: ()->
    @popups = $(".popups .popup")

  error: (message)->
    switch message.constructor
      when String
        alert message
      when Array
        alert message.join(", ")
      else
        str = ""
        for key,elem of message
          str += key + ": " + elem.join(", ")
        alert str    

  ajax: (hash)->
    $.ajax
      type: hash.type || 'POST'
      url: hash.url
      data: hash.data
      success: (data)->
        if data.errors
          if data.errors.constructor == String
            helper.error data.errors
          else
            helper.errors data.errors
        else
          helper.close_popups()
          if hash.callback
            hash.callback data
      dataType: 'json'   

  send_form: (hash)->
    self = this
    if @_form_validation(hash.element)
      $.ajax
        type: hash.type || 'POST'
        url: hash.url
        data: new FormData(hash.element)
        processData: false
        contentType: false
        success: (data)->
          if data.errors
            helper.error data.errors
          else
            helper.close_popups()
            self.clear_form hash.element
            if hash.callback
              hash.callback data
        dataType: 'json'   
    false  

  _form_validation: (form)->
    ok = true
    for input in $(form).find("input.precense")
      if !$(input).val()
        $(input).addClass "error"
        ok = false
      else
        $(input).removeClass "error"
    passwords = $(form).find("input[type='password']")
    errors = []
    for input in passwords
      if $(input).val().length < 8
        $(input).addClass "error"
        errors.push "min width of password 8"
        ok = false
    if (passwords.length > 1) && (passwords.eq(0).val() != passwords.eq(1).val())
      passwords.addClass "error"
      errors.push "passwords don't match"
      ok = false
    else
      passwords.removeClass "error"
    if errors.length > 0
      @error errors
    ok

  clear_form: (element)->
    $(element).find("input, textarea").not("input[type='submit']").val("")

  close_popups: ()->
    @popups.addClass "hide"

# create class cast
helper = new Helper()
window.helper = helper