
# Require

THREE = require \three-js
TWEEN = require \tween-js

{ Circle } = require \./shape.ls
{ Sprite } = require \./sprite.ls

settings = require \../materials.ls


# Rotator Greeble

Rotator = (height) ->
  speed = 30 * 1000
  group = new THREE.Object3D
  n = 5

  layers = [
    Sprite "img/ring-1.png", settings.colors.main, 400
    Sprite "img/ring-2.png", settings.colors.main, 400
    Sprite "img/ring-3.png", settings.colors.main, 400
    Sprite "img/ring-4.png", settings.colors.main, 400
    Circle 400
  ]

  layers.map (layer, i) ->
    group.add layer
    layer.position.z = i * height/(n-1) - height/2
    random-rotation = if Math.random! > 0.5 then -tau else tau
    tween = new TWEEN.Tween layer.rotation .to { z : random-rotation }, Math.random! * speed/2 + speed/2
    tween.on-complete -> layer.rotation.z = 0; tween.start!
    tween.start!

  return group


# Export

module.exports = { Rotator }

