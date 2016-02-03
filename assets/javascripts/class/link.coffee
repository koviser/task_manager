# Pronto Film

'use strict'
class Link
  constructor: ()->
    @state = History.getState()

  set_url: (url)->
    History.pushState(null, null, url)

  root: ->
    @set_url "/"
   
# create class Link
link = new Link()
window.link = link