

{model} = require './model'
{view} = require './view'

canvas = document.querySelector '#canvas'

do resize = ->
  canvas.setAttribute 'width', innerWidth
  canvas.setAttribute 'height', innerHeight
  model.area =
    cx: innerWidth / 2
    cy: innerHeight / 2
    w: innerWidth
    h: innerHeight

window.addEventListener 'resize', resize

canvas.addEventListener 'mousewheel', (event) ->
  event.preventDefault()
  model.grow event.deltaY

drag =
  during: no
  x: 0
  y: 0

canvas.addEventListener 'mousedown', (event) ->
  event.preventDefault()
  drag.during.x = event.offsetX
  drag.during.y = event.offsetY
  drag.during = yes

canvas.addEventListener 'mousemove', (event) ->
  return unless drag.during
  model.move
    x: event.offsetX - drag.x
    y: event.offsetY - drag.y
  drag.x = event.offsetX
  drag.y = event.offsetY

canvas.addEventListener 'mouseup', (event) ->
  event.preventDefault()
  drag.during = no

view.start()
