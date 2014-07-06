
# Require

THREE = require \three-js

settings = require \../materials.ls


# Greebles

Line = (verts, mat = settings.mats.line-main) ->
  geom = new THREE.Geometry
  for [ x, y ] in verts
    geom.vertices.push new THREE.Vector3 x, y, 0
  new THREE.Line geom, mat

Lines = (lines, mat) ->
  group = new THREE.Object3D
  for line in lines
    group.add Line line, mat
  return group


# Export

module.exports = { Line, Lines }

