
T = 10
M = 3 ** T
velocity = 1

canvas = document.querySelector '#canvas'
context = canvas.getContext '2d'

{model} = require './model'

mod = (x) ->
  offset = x % 3
  offset += 3 if offset < 0
  offset

digitMap = [
  [6, 1, 8]
  [7, 5, 3]
  [2, 9 ,4]
]

exports.view =
  scale: model.scale
  x: model.x
  y: model.y

  start: ->
    console.log 'view start'
    time = (new Date).getTime()
    do loopRender = =>
      now = (new Date).getTime()
      diff =
        x: model.x - @x
        y: model.y - @y
        scale: model.scale - @scale
      limit = (velocity * (now - time)) * @scale * @scale
      for key, value of diff
        if (Math.abs value) > limit
          if value > 0
            @[key] += limit
          else
            @[key] -= limit
        else
          @[key] = model[key]
      time = now

      context.clearRect 0, 0, model.area.w, model.area.h
      @render()
      console.log 'render'
      requestAnimationFrame =>
        do loopRender
        # f = => do loopRender
        # setTimeout f, 10

  render: ->
    for i in [1..(T + 3)]
      if @scale < i < (6 * @scale)
        unit = 3 ** i
        context.font = "#{unit / @scale}px Menlo"
        context.textBaseline = 'middle'
        context.textAlign = 'center'
        if (2.8 * @scale) < i < (3.2 * @scale)
          context.globalAlpha = 1
        else
          context.globalAlpha = 0.3

        closest =
          xn: (@x / unit).toFixed()
          yn: (@y / unit).toFixed()
        closest.x = closest.xn * unit
        closest.y = closest.yn * unit

        area = model.area

        draw = (r) =>
          index =
            x: (mod r.x) + 1
            y: (mod r.y) + 1
          if index.x is 3 then index.x = 0
          if index.y is 3 then index.y = 0
          digit = digitMap[index.y][index.x]

          p =
            x: model.area.cx + ((r.x * unit) - @x) / @scale
            y: model.area.cy + ((r.y * unit) - @y) / @scale

          @drawDigit p, unit, digit

        @walkX unit, closest, draw

  walkX: (unit, closest, callback) ->
    area = model.area
    abs = Math.abs
    limit = area.cx * @scale
    x = closest.xn - 1
    while abs(unit * x - closest.x) < limit
      x += 1
      @walkY unit, closest, (y) -> callback {x, y}
    x = closest.xn
    while abs(unit * x - closest.x) < limit
      x -= 1
      @walkY unit, closest, (y) -> callback {x, y}

  walkY: (unit, closest, callback) ->
    area = model.area
    abs = Math.abs
    limit = area.cy * @scale
    y = closest.yn - 1
    while abs(unit * y - closest.y) < limit
      y += 1
      callback y
    y = closest.yn
    while abs(unit * y - closest.y) < limit
      y -= 1
      callback y

  drawDigit: (p, unit, digit) ->
    context.fillText "#{digit}", p.x, p.y