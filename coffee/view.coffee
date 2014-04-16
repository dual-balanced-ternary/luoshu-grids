
T = 10
M = 3 ** T

canvas = document.querySelector '#canvas'
context = canvas.getContext '2d'

{model} = require './model'

mod = (x) ->
  offset = x % 3
  offset += 3 if offset < 0

digitMap = [
  [6, 1, 8]
  [7, 5, 3]
  [2, 9 ,4]
]

exports.view =
  scale: model.getScale()
  x: model.x
  y: model.y

  start: ->
    console.log 'view start'

  render: ->
    for i in [1..T]
      if 2 < (i / scale) < 5
        unit = 3 ** i
        use =
          x: ((model.area.cx - @x) / unit).toFixed()
          y: ((model.area.cy - @y) / unit).toFixed()

        draw = (r) =>
          index =
            x: (mod r.x) + 1
            y: (mod -r.y) + 1
          digit = digitMap[index.y][index.x]

          p =
            x: model.area.cx + (r.x * unit)
            y: model.area.cy + (r.y * unit)

          @drawDigit p, unit, digit

        walkX unit, draw

  walkX: (unit, callback) ->
    x = -1
    while (unit * (x - 1)) < (model.area.w / 2)
      x += 1
      walkY unit, (y) -> callback {x, y}
    x = 0
    while (u.x * (x + 1)) > (model.area.w / 2)
      x -= 1
      walkY unit, (y) -> callback {x, y}

  walkY: (unit, callback) ->
    y = -1
    while (unit * (y - 1)) < (model.area.h / 2)
      y += 1
      callback y
    y = 0
    while (unit * (y + 1)) > (model.area.h / 2)
      y -= 1
      callback y

  drawDigit: (p, unit, digit) ->
    console.log 'draw'