
# Require

THREE = require \three-js


# State

color = new THREE.Color 1, 1, 1


# Greebles definition

{ Group }   = require \./group.ls
{ Stack }   = require \./stack.ls
{ Digit }   = require \./digit.ls
{ Rotator } = require \./rotator.ls
{ Sprite }:sprites  = require \./sprite.ls
{ Button, ButtonArray } = require \./button.ls
{ Shape, Hexagon, Octagon }:shapes = require \./shape.ls
{ Text, Label, DynamicTexture } = require \./text.ls


# Misc Greebles

Hex = (name, digit) ->
  group = new THREE.Object3D

  layer-z = [ 0, -10, -20, -20 ]

  layers = [
    ring = Sprite 'img/ring.svg', 352
    hex1 = Hexagon 252
    hex2 = Hexagon 252
    fill = Sprite 'img/hex-filled.png',  252
  ]

  layers.map (l, i) ->
    l.position.z = layer-z[i]
    group.add l

  #label = Label name, \hex-label
  #label.position <<< { y: -90, z: 57 }
  #group.add label

  #text = Text digit, \hex-text
  #text.position.z = 65
  #group.add text

  return group

Octants = ->
  group = Group \octants

  layer-z = [ 0, 10, 20, 80, 90 ]

  layers = [
    Sprite "img/ring.png", 250
    Octagon 200
    Octagon 190
    Sprite "img/oct-filled.png", 55
    Sprite "img/oct-filled.png", 40
  ]

  layers.map (l, i) ->
    l.position.z = layer-z[i]
    group.add l

  return group


# Export

module.exports = { Group, Sprite, Text, Label, Button, ButtonArray, Octants, Hex, Digit, Rotator }

module.exports.set-color = ->
  color := it
  sprites.set-color it
  shapes.set-color it

module.exports.get-color = ->
  color!


