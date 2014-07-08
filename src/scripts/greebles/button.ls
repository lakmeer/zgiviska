
# Require

THREE = require \three-js

{ Lines }  = require \./lines.ls
{ Sprite } = require \./sprite.ls
{ Label, Text }  = require \./text.ls
{ FilledRect } = require \./shape.ls

settings = require \../materials.ls


Group = (λ) ->
  group = new THREE.Object3D
  map λ!map group~add
  return group

Frame = (w, h, l) ->
  Lines [
    [ [ w/-2, h/ 2 - l ], [ w/-2, h/ 2 ], [ w/-2 + l, h/ 2 ] ]
    [ [ w/ 2, h/-2 + l ], [ w/ 2, h/-2 ], [ w/ 2 - l, h/-2 ] ]
    [ [ w/ 2, h/ 2 - l ], [ w/ 2, h/ 2 ], [ w/ 2 - l, h/ 2 ] ]
    [ [ w/-2, h/-2 + l ], [ w/-2, h/-2 ], [ w/-2 + l, h/-2 ] ]
  ]


# Greebles Definitions

Button = (button-text = 'button') ->

  button-width  = w = 90
  button-height = h = 30
  button-depth  = d = 6
  font-size     = f = 16
  corner-length = l = 6

  button = new THREE.Object3D

  inactive-group = Group ->
    back = Sprite \img/bg-stripes.png, settings.colors.main, w, h
    text = Text button-text, w, h, size: font-size
    text.position.z = d
    [ back, text ]

  active-group = Group ->
    back = FilledRect w, h, { color: settings.mats.strong-main }
    text = Text button-text, w, h, size: font-size, color: new THREE.Color 0, 0, 0
    text.position.z = d
    [ back, text ]

  frame = Frame w, h, corner-length
  frame.position.z = d

  active-group.traverse (.visible = no)

  [ active-group, inactive-group, frame ].map button~add

  # Custom methods
  button.set-active = (state) ->
    if state
      active-group.traverse   (.visible = yes)
      inactive-group.traverse (.visible = no)
    else
      active-group.traverse   (.visible = no)
      inactive-group.traverse (.visible = yes)

  return button


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

  # Custom Methods

  group.set-active = (n, state = on) ->
    buttons[n].set-active state

  return group


module.exports = { Button, ButtonArray }
