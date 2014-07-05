
# Require

THREE = require \three-js
TWEEN = require \tween-js


# Helpers

SECONDS = 1000


# Greeble dependencies

{ Group } = require \./group.ls
{ Sprite } = require \./sprite.ls


# Rotator Greeble

Rotator = (n, height) ->
  speed = 30 * SECONDS
  rings = [ Sprite "img/ring-#{i+1}.png", 400 for i from 0 til n ]
  group = Group!

  rings.map (ring, i) ->
    group.add ring
    ring.position.z = i * height/(n-1) - height/2
    random-rotation = if Math.random! > 0.5 then -tau else tau
    tween = new TWEEN.Tween ring.rotation .to { z : random-rotation }, Math.random! * speed/2 + speed/2
    tween.on-complete -> ring.rotation.z = 0; tween.start!
    tween.start!

  return group


# Export

module.exports = { Rotator }

