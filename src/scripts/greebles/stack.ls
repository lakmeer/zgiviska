
# Require

THREE = require \three-js

{ Sprite } = require \./sprite.ls


# Greebles Definitions

Layer = ([ src, z, w ]) ->
  layer = Sprite src, w, w
  layer.position.z = z
  return layer

Stack = (layers) ->
  stack = new THREE.Object3D
  sprites = layers.map Layer
  sprites.map stack~add
  return stack


# Exports

module.exports = { Stack }

