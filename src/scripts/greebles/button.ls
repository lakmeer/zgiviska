
{ Group }  = require \./group.ls
{ Sprite } = require \./sprite.ls
{ Label, Text }  = require \./text.ls

Button = (text = 'button') ->
  group = Group "button active"
  frame = Sprite \img/button-frame.png, 89, 30
  back  = Sprite \img/bg-stripes.png,   89, 30
  text  = Text text, 89, 30, size: 16

  frame.position.z = text.position.z  = 6
  [ back, frame, text ].map group~add
  return group


ButtonArray = (name, texts) ->

  # Metrics
  a = 19
  b = 51

  button-coords = [ [ a, -b ], [ -a, -b ], [ a, b ], [ -a, b ] ]
  object = Group!

  label = Label name, 200, 30
  label.position.y = 45
  object.add label

  buttons = texts.map Button
  buttons.map (button, i) ->
    button.position.y = button-coords[i][0] - 16
    button.position.x = button-coords[i][1]
    object.add button

  return object


module.exports = { Button, ButtonArray }
