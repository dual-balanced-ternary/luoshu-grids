
T = 10
M = 3 ** T

exports.model =
  wheel: 3
  x: 0
  y: 0
  area: {}
  getScale: ->
    @wheel / 3

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