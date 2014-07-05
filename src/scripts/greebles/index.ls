
# Require

THREE = require \three-js


# Greebles definition

{ Group }   = require \./group.ls
{ Stack }   = require \./stack.ls
{ Digit }   = require \./digit.ls
{ Rotator } = require \./rotator.ls
{ Sprite }:sprites  = require \./sprite.ls
{ Button, ButtonArray } = require \./button.ls
{ Text, Label, DynamicTexture } = require \./text.ls


# More

Hex = (name, digit) ->
  group = Group \hex

  group.add Stack [
    * 'img/hex-filled.png', 0,  252
    * 'img/hex.png',        30, 242
    * 'img/ring.svg',       50, 352
  ]

  #label = Label name, \hex-label
  #label.position <<< { y: -90, z: 57 }
  #group.add label

  #text = Text digit, \hex-text
  #text.position.z = 65
  #group.add text

  return group

Octants = ->
  group = Group \octants
  group.add Stack [
    * "img/ring.png",       0,  250
    * "img/oct.png",        10, 200
    * "img/oct.png",        20, 190
    * "img/oct-filled.png", 80, 55
    * "img/oct-filled.png", 90, 40
  ]

  return group

# Export

module.exports = { Group, Sprite, Text, Label, Button, ButtonArray, Octants, Hex, Digit, Rotator }

module.exports.use-default-color = sprites~set-default-color


