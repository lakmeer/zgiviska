

# Require

THREE = require \three-js

settings = require \../materials.ls


# Shape creator

Polygon = (θ, s, z) -->
  geom = new THREE.CircleGeometry z/2, s, θ
  geom.vertices.shift!
  new THREE.Line geom, settings.mats.line-main

FilledPolygon = (θ, s, z) -->
  geom = new THREE.CircleGeometry z/2, s, θ
  new THREE.Mesh geom, settings.mats.fill-main


# Shape definitions

Square  = Polygon pi/4, 4
Hexagon = Polygon pi/1, 6
Octagon = Polygon pi/8, 8

FilledHexagon = FilledPolygon pi/1, 6
FilledOctagon = FilledPolygon pi/8, 8

Circle = Polygon 0, 64


# Export

module.exports = { Polygon, Circle, Hexagon, Octagon, FilledPolygon, FilledHexagon, FilledOctagon }

