
# Require

THREE = require \three-js


# State

color = new THREE.Color 1, 1, 1


# Helpers

with-tex = (tex) ->
  map: tex
  color: color
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

set-color = -> color := it
get-color = -> color


# Export

module.exports = { Sprite, set-color, get-color }

