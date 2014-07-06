

# Require

THREE = require \three-js

# Internal State

color      = new THREE.Color 1, 1, 1
linewidth = 2


# Shape creator

Shape = (verts) ->
  geom = new THREE.Geometry
  for [ x, y ] in verts => geom.vertices.push new THREE.Vector3 x, y, 0
  new THREE.Line geom, new THREE.LineBasicMaterial { color, linewidth }


# Shape definitions

Square = (z) ->
  Shape [ [-z,-z],[-z,z],[z,z],[z,-z],[-z,-z] ]

Hexagon = (z) ->
  z = z / 2
  a = z * (sqrt 3) / 2
  Shape [ [-z,0],[-z/2,-a],[z/2,-a],[z,0],[z/2,a],[-z/2,a],[-z,0] ]

Octagon = (z) ->
  z = z / 2
  a = z / (1 + sqrt 2)
  Shape [ [-z,-a],[-a,-z],[a,-z],[z,-a],[z,a],[a,z],[-a,z],[-z,a],[-z,-a] ]


# Color functions

set-color = -> color := it
get-color = -> color


# Export

module.exports = { Shape, Square, Hexagon, Octagon, set-color, get-color }

