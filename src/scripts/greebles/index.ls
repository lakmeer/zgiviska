
# Require

THREE = require \three-js

settings = require \../materials.ls


# Greebles definition

{ Group }   = require \./group.ls
{ Stack }   = require \./stack.ls
{ Digit }   = require \./digit.ls
{ Rotator } = require \./rotator.ls
{ Sprite, all }  = require \./sprite.ls
{ Line, Lines } = require \./lines.ls
{ Button, ButtonArray } = require \./button.ls
{ Polygon, Square, Hexagon, Octagon } = require \./shape.ls
{ Text, Label, TrimLabel, DynamicTexture } = require \./text.ls
{ FilledPolygon, FilledHexagon, FilledOctagon } = require \./shape.ls


# Misc Greebles

Hex = (name, digit) ->
  group = new THREE.Object3D

  layers = [
    [   0, Sprite 'img/ring.svg', settings.colors.main, 352 ]
    [ -10, Hexagon 252 ]
    [ -20, Hexagon 252 ]
    [ -20, FilledHexagon 252 ]
  ].map ([z, l], i) -> l.position.z = z; group.add l; l

  label = TrimLabel name, 50, 20
  label.position <<< { y: -90, z: 5 }
  group.add label

  text = Text digit, 100, 100, { size: 130 }
  text.position.z = 10
  group.add text

  return group

Octants = ->
  group = new THREE.Object3D

  layer-z = [ 0, 10, 20, 80, 90 ]

  layers = [
    Sprite "img/ring.png", settings.colors.main, 250
    Octagon 200
    Octagon 190
    FilledOctagon 55
    FilledOctagon 40
  ]

  layers.map (l, i) ->
    l.position.z = layer-z[i]
    group.add l

  Object.define-property group, \color, do
    get: ->
    set: (c) -> layers.map -> it.color = c

  return group



# Export

module.exports = {
  Group, Sprite, Text, Label, Button, ButtonArray,
  Octants, Hex, Digit, Rotator, Line, Lines, allSprites : all
}

