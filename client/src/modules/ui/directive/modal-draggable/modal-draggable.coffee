'use strict'

# Event driven focus setter, pretty awesome!

angular.module 'weaver.ui'

.directive('weaverModalDraggable', ($document) ->

  (scope, element) ->
    startX = 0
    startY = 0
    x = 0
    y = 0

    mousemove = (event) ->
      y = event.screenY - startY
      x = event.screenX - startX
      element.css({
        top: y + 'px',
        left: x + 'px'
      })

    mouseup = ->
      $document.unbind('mousemove', mousemove)
      $document.unbind('mouseup', mouseup)

    element= angular.element(document.getElementsByClassName("modal-dialog"))

    element.css({
      cursor: 'default'
    })

    element.on('mousedown',  (event) ->
      #event.preventDefault()
      startX = event.screenX - x
      startY = event.screenY - y
      $document.on('mousemove', mousemove)
      $document.on('mouseup', mouseup)
    )
)
