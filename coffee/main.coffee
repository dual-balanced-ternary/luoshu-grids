
canvas = document.querySelector '#canvas'
context = canvas.getContext '2d'

console.log context

T = 10
M = 3 ** T

area = {}
model =
  wheel: 3
  x: 0
  y: 0
  getScale: ->
    @wheel / 3
  base:
    x: 0
    y: 0
  grow: (delta) ->
    @wheel += delta
    if @wheel < 3 then @wheel = 3
    else if @wheel > (3 * T) then @wheel = (3 * T)
    console.log @getScale()
  move: (p) ->
    @x += p.x
    @y += p.y
    maxW = (M / 2) / @getScale()
    maxH = (M / 2) / @getScale()
    if @x > maxW then @x = maxW
    else if @x < -maxW then @x = -maxW
    if @y > maxH then @y = maxH
    else if @y < -maxH then @y = -maxH
    console.log @x, @y

view =
  scale: model.getScale()
  x: model.x
  y: model.y

resize = ->
  area =
    cx: innerWidth / 2
    cy: innerHeight / 2
    w: innerWidth
    h: innerHeight

  canvas.setAttribute 'width', innerWidth
  canvas.setAttribute 'height', innerHeight

do resize
window.addEventListener 'resize', resize

canvas.addEventListener 'mousewheel', (event) ->
  model.grow event.deltaY

dragging = no

canvas.addEventListener 'mousedown', (event) ->
  model.base.x = event.offsetX
  model.base.y = event.offsetY
  dragging = yes

canvas.addEventListener 'mousemove', (event) ->
  return unless dragging
  model.move
    x: event.offsetX - model.base.x
    y: event.offsetY - model.base.y
  model.base.x = event.offsetX
  model.base.y = event.offsetY

canvas.addEventListener 'mouseup', (event) ->
  dragging = no

