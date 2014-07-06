
# Require

THREE = require \three-js


# Catalog

all = []


# Helpers

with-tex = (tex, color) ->
  map: tex
  color: color
  transparent: yes
  side: THREE.DoubleSide
  #blending: THREE.AdditiveBlending
  depth-test: no

auto-texture = (img) ->
  if typeof img is \string
    new THREE.ImageUtils.loadTexture img
  else
    new THREE.Texture img


# Constructor

Sprite = (img, color, w, h = w) ->
  tex = auto-texture img
  tex.anisotropy = 16
  tex.needs-update = yes

  mat = new THREE.MeshBasicMaterial with-tex tex, color
  obj = new THREE.Mesh (new THREE.PlaneGeometry w, h), mat

  all.push obj

  return obj


# Export

module.exports = { Sprite, all }

