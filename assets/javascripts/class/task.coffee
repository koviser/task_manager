'use strict'
class Task
  constructor: ()->
    @popup = $(".popups .task_form")
    @popup_edit = $(".popups .task_edit")
    @form_c = @popup.find "form.create"
    @adjustment = null

  set_sort: ->    
    helper.ajax
      url: "/tasks/sortable"
      data: @_sort_ids()
      callback: (data)->
        # login.show()

  _sort_ids: ->
    {
      tasks: {
        hard: @_array $("ol.hard li.castom_info")
        middle: @_array $("ol.middle li.castom_info")
        easy: @_array $("ol.easy li.castom_info")
      }
    }

  _array: (elements)->
        elements.map(->
          $(this).data "id"
        ).get()

  drag_d: ->
    $( 'ol.example' ).sortable( "destroy" )

  drag: ->
    self = this
    @adjustment = null    
    $('ol.example').sortable
      group: 'example'
      pullPlaceholder: false
      onDrop: ($item, container, _super) ->
        self.set_sort()
        $clonedItem = $('<li/>').css(height: 0)
        $item.before $clonedItem
        $clonedItem.animate 'height': $item.height()
        $item.animate $clonedItem.position(), ->
          $clonedItem.detach()
          _super $item, container
          return
        return
      onDragStart: ($item, container, _super) ->
        offset = $item.offset()
        pointer = container.rootGroup.pointer
        self.adjustment =
          left: pointer.left - (offset.left)
          top: pointer.top - (offset.top)
        _super $item, container
        return
      onDrag: ($item, position) ->    
        $item.css
          left: position.left - (self.adjustment.left)
          top: position.top - (self.adjustment.top)
        return      

# create class cast
task = new Task()
window.task = task