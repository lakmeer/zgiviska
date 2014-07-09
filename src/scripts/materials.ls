
# Require

THREE = require \three-js


# Reusable settings

fill-opts = (color, opacity) ->
  color: color
  transparent: yes
  opacity: opacity
  side: THREE.DoubleSide
  blending: THREE.AdditiveBlending

# Line Width

linewidth = 1


# Color Palette

color-values =
  main : 0x00ffff
  trim : 0xff6d2c

colors =
  main : new THREE.Color color-values.main
  trim : new THREE.Color color-values.trim


# Materials

mats =
  line-main : new THREE.LineBasicMaterial { color: colors.main, linewidth }
  line-trim : new THREE.LineBasicMaterial { color: colors.trim, linewidth }
  fill-main : new THREE.MeshBasicMaterial fill-opts colors.main, 0.3
  fill-trim : new THREE.MeshBasicMaterial fill-opts colors.trim, 0.3
  strong-main : new THREE.MeshBasicMaterial fill-opts colors.main, 1
  strong-trim : new THREE.MeshBasicMaterial fill-opts colors.trim, 1


# Exports

module.exports = { colors, mats }

