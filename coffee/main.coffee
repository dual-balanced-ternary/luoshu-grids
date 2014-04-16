
canvas = document.querySelector '#canvas'
context = canvas.getContext '2d'

{model} = require './model'
{view} = require './view'

view.start()

resize = ->
  canvas.setAttribute 'width', innerWidth
  canvas.setAttribute 'height', innerHeight

do resize
window.addEventListener 'resize', resize

canvas.addEventListener 'mousewheel', (event) ->
  model.grow event.deltaY

drag =
  during: no
  x: 0
  y: 0

canvas.addEventListener 'mousedown', (event) ->
  drag.during.x = event.offsetX
  drag.during.y = event.offsetY
  drag.during = yes

canvas.addEventListener 'mousemove', (event) ->
  return unless dragging
  model.move
    x: event.offsetX - drag.x
    y: event.offsetY - drag.y
  drag.x = event.offsetX
  drag.y = event.offsetY

canvas.addEventListener 'mouseup', (event) ->
  drag.during = no
