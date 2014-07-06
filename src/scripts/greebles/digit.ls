
# Require

{ Group  } = require \./group.ls
{ Text   } = require \./text.ls
{ Sprite } = require \./sprite.ls

settings = require \../materials.ls


# Digit Greeble

Digit = (name, value) ->
  group = Group!

  backing = Sprite \img/bg-digit.png, settings.colors.main, 72, 90
  backing.position.y = -9
  group.add backing

  label = Text name, 72, 30, { size: 12, align: \left }
  label.position.y = 50
  group.add label

  text = Text value, 50, 50, { size: 80 }
  text.position <<< z: 10, y: -5
  group.add text

  return group


# Export

module.exports = { Digit }

