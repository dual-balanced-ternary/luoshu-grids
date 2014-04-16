
{model} = require './model'

exports.view =
  scale: model.getScale()
  x: model.x
  y: model.y

  start: ->
    console.log 'view start'