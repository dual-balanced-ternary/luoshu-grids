
T = 10
M = 3 ** T
velocity = 0.01

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
      limit = velocity * (now - time)
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
        f = => do loopRender
        setTimeout f, 10

  render: ->
    for i in [1..T]
      if @scale < i < (5 * @scale)
        unit = 3 ** i
        context.font = "#{unit / @scale}px Menlo"
        if (2.5 * @scale) < i < (3.5 * @scale)
          context.globalAlpha = 1
        else
          context.globalAlpha = 0.3
        use =
          x: ((model.area.cx - @x) / unit).toFixed()
          y: ((model.area.cy - @y) / unit).toFixed()

        draw = (r) =>
          index =
            x: (mod r.x) + 1
            y: (mod r.y) + 1
          if index.x is 3 then index.x = 0
          if index.y is 3 then index.y = 0
          digit = digitMap[index.y][index.x]

          p =
            x: model.area.cx + (r.x * unit)
            y: model.area.cy + (r.y * unit)

          @drawDigit p, unit, digit

        @walkX unit, draw

  walkX: (unit, callback) ->
    x = -1
    while (unit * (x - 1)) < ((model.area.w / 2) * @scale)
      x += 1
      @walkY unit, (y) -> callback {x, y}
    x = 0
    while (unit * (x + 1)) > -((model.area.w / 2) * @scale)
      x -= 1
      @walkY unit, (y) -> callback {x, y}

  walkY: (unit, callback) ->
    y = -1
    while (unit * (y - 1)) < ((model.area.h / 2) * @scale)
      y += 1
      callback y
    y = 0
    while (unit * (y + 1)) > -((model.area.h / 2) * @scale)
      y -= 1
      callback y

  drawDigit: (p, unit, digit) ->
    context.textBaseline = 'middle'
    context.textAlign = 'center'
    context.fillText "#{digit}", p.x, p.y