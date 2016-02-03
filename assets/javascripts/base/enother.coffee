$(".popup").click (event)->
  if $(event.target).closest("form").length
    return
  helper.close_popups()

$(".popup").on "click", ".close", ->
  helper.close_popups()