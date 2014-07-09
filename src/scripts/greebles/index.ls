
# Require

THREE = require \three-js
TWEEN = require \tween-js

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

  # Octagon layers
  layer-z = [ 0, 10, 20, 47, 60 ]
  layers = [
    Sprite "img/ring.png", settings.colors.main, 250
    Octagon 200
    Octagon 190
    FilledOctagon 55
    FilledOctagon 40
  ].map (l, i) ->
    l.position.z = layer-z[i]
    group.add l

  # Octant indicator
  indicator = new THREE.Object3D

  k = 95
  p = 120

  g = new THREE.CircleGeometry k, 8
  g.vertices.0.z = 40

  geom = new THREE.Geometry
  geom.vertices.push g.vertices.0
  geom.vertices.push g.vertices.1
  geom.vertices.push g.vertices.2
  geom.vertices.push g.vertices.0
  geom.faces.push new THREE.Face3 0 1 2

  pointer-geom = geom.clone!
  pointer-geom.vertices.push new THREE.Vector3 (p * cos pi/8), (p * sin pi/8), -20
  pointer-geom.faces.push new THREE.Face3 0 1 2
  pointer-geom.faces.push new THREE.Face3 1 2 4
  pointer-geom.compute-face-normals!

  left-wing  = new THREE.Mesh geom, settings.mats.fill-main
  left-wing.rotation.z = pi/8

  right-wing = left-wing.clone!
  right-wing.rotation.z = pi/8 + pi/4 + pi/4

  pointer = new THREE.Mesh pointer-geom, settings.mats.fill-main
  pointer.rotation.z = pi/8 + pi/4

  [ left-wing, right-wing, pointer ].map indicator~add

  indicator.position.z = 20
  group.add indicator

  # Needle
  needle = Lines [[ [0,0],[0,p+20] ]], settings.mats.line-trim
  needle.children.0.geometry.vertices.0.z = 60
  group.add needle

  # Custom Methods
  group.needle-visibility = (state) ->
    needle.traverse (.visible = state)

  group.set-angle  = (angle) ->
    needle.rotation.z = angle

  group.set-octant = (n) ->
    if n is 0
      indicator.traverse (.visible = no)
    else
      indicator.traverse (.visible = yes)
      indicator.rotation.z = (n - 1) * pi/4

  # Initial state
  group.needle-visibility off
  group.set-octant 0

  return group


# Export

module.exports = {
  Group, Sprite, Text, Label, Button, ButtonArray,
  Octants, Hex, Digit, Rotator, Line, Lines, allSprites : all
}

