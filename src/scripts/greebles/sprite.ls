
# Require

THREE = require \three-js


# State

default-color = new THREE.Color 1, 1, 1


# Helpers

with-tex = (tex) ->
  map: tex
  color: default-color
  transparent: yes
  side: THREE.DoubleSide
  blending: THREE.AdditiveBlending
  depth-test: no


# Instance Method Mixin



# Constructor

Sprite = (img, w, h = w) ->

  tex = new (if typeof img is \string then THREE.ImageUtils.loadTexture else THREE.Texture ) img
  tex.anisotropy = 16
  tex.needs-update = yes

  mat = new THREE.MeshBasicMaterial with-tex tex
  obj = new THREE.Mesh (new THREE.PlaneGeometry w, h), mat

  return obj


# Static methods

set-default-color = (color) -> default-color := color


# Export

module.exports = { Sprite, set-default-color }

