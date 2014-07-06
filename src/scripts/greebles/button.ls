
# Require

THREE = require \three-js

{ Lines }  = require \./lines.ls
{ Sprite } = require \./sprite.ls
{ Label, Text }  = require \./text.ls

settings = require \../materials.ls


# Greebles Definitions

Button = (text = 'button') ->

  button-width  = w = 90
  button-height = h = 30
  button-depth  = d = 6
  font-size     = f = 16
  corner-length = l = 6

  group = new THREE.Object3D
  back  = Sprite \img/bg-stripes.png, settings.colors.main, w, h
  text  = Text text, w, h, size: font-size

  lines = Lines [
    [ [ w/-2, h/ 2 - l ], [ w/-2, h/ 2 ], [ w/-2 + l, h/ 2 ] ]
    [ [ w/ 2, h/-2 + l ], [ w/ 2, h/-2 ], [ w/ 2 - l, h/-2 ] ]
    [ [ w/ 2, h/ 2 - l ], [ w/ 2, h/ 2 ], [ w/ 2 - l, h/ 2 ] ]
    [ [ w/-2, h/-2 + l ], [ w/-2, h/-2 ], [ w/-2 + l, h/-2 ] ]
  ]

  lines.position.z = text.position.z = d

  [ back, text, lines ].map group~add

  return group


ButtonArray = (name, texts) ->

  # Metrics
  a = 19
  b = 51

  button-coords = [ [ a, -b ], [ -a, -b ], [ a, b ], [ -a, b ] ]
  group = new THREE.Object3D

  label = Label name, 200, 30
  label.position.y = 45
  group.add label

  buttons = texts.map Button
  buttons.map (button, i) ->
    button.position.y = button-coords[i][0] - 16
    button.position.x = button-coords[i][1]
    group.add button

  return group


module.exports = { Button, ButtonArray }
