
THREE = require \three-js

Group = (cn = "", pos = { x: 0, y: 0 }) ->
  group = new THREE.Object3D
  group.position <<< pos
  return group

module.exports = { Group }

