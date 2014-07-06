
# Require

THREE = require \three-js


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
  fill-main : new THREE.MeshBasicMaterial { color: colors.main, transparent: yes, opacity: 0.3 }
  fill-trim : new THREE.MeshBasicMaterial { color: colors.trim, transparent: yes, opacity: 0.3 }


# Exports

module.exports = { colors, mats }

