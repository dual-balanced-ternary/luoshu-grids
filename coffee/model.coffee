
T = 10
R = 90
M = R ** T

exports.model =
  wheel: 3
  scale: 1
  x: 0
  y: 0
  area: {}
  getScale: ->
    @scale = @wheel / R
    @scale

  grow: (delta) ->
    @wheel += delta
    if @wheel < R then @wheel = R
    else if @wheel > (R * T) then @wheel = (R * T)
    console.log @getScale()

  move: (p) ->
    @x += p.x * @scale
    @y += p.y * @scale
    maxW = (M / 2) / @scale
    maxH = (M / 2) / @scale
    if @x > maxW then @x = maxW
    else if @x < -maxW then @x = -maxW
    if @y > maxH then @y = maxH
    else if @y < -maxH then @y = -maxH
    console.log @x, @y