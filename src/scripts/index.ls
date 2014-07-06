
# Require

THREE = require \three-js
TWEEN = require \tween-js
require! './helpers.ls'

Stage    = require \./stage.ls
Greebles = require \./greebles/index.ls

# Settings

settings = require \./materials.ls


# Stage setup

stage = new Stage
root  = new THREE.Object3D


# Central core

rotator = Greebles.Rotator 600
rotator.position.z = -450

hex = Greebles.Hex \pitch, \F
hex.position.z = -50


# Joystick radars

left-stick  = Greebles.Octants!
left-stick.position <<< { x: -520, y: -325, z: -20 }

right-stick = Greebles.Octants!
right-stick.position <<< { x: 520, y: -325, z: -20 }


# Buttons

left-button-group  = Greebles.Group \left-button-group  x: -250, y: -247
right-button-group = Greebles.Group \right-button-group x:  250, y: -247

left-buttons  = Greebles.ButtonArray 'Left  wand button array', [ 1, 2, 3, 4 ]
right-buttons = Greebles.ButtonArray 'Right wand button array', [ 1, 2, 3, 4 ]

left-home = Greebles.Button \home
left-home.position.y = -90

right-home = Greebles.Button \home
right-home.position.y = -90


# Button diagram

left-gfx = new THREE.Object3D
left-gfx.add Greebles.Sprite \img/button-diagram.png, settings.colors.main, 303, 303

lines =
  [ [ 98, -33 ], [  74,  -33 ] ]
  [ [ 98, -70 ], [  74,  -70 ] ]
  [ [152, -127], [  91, -127 ], [   74, -108 ], [   74,  76 ] ]
  [ [ 67,  93 ], [ -100,  93 ], [ -152,   38 ] ]
  [ [ 58,  82 ], [  -36,  82 ], [  -74,  130 ], [ -102, 130 ] ]

lines = Greebles.Lines lines

left-gfx.add lines

left-gfx.position <<< { x: -197, y: 38 }

right-gfx = left-gfx.clone!
right-gfx.position <<< { x: 197, y: 38 }
right-gfx.rotation.y = pi

[ left-buttons
  left-home
  left-gfx
].map left-button-group~add

[ right-buttons
  right-home
  right-gfx
].map right-button-group~add


# Tuning display

tonic  = Greebles.Digit \root, \A
octave = Greebles.Digit \octave, 2

tonic.position.x  =  -54
tonic.position.y  = -252
octave.position.x =   54
octave.position.y = -252


# Add all to root

[ rotator
  left-stick
  right-stick
  hex
  tonic
  octave
  left-button-group
  right-button-group
].map root~add


# Add root to stage

stage.add root
root.position.y = 100


# Onready

window.onload = ->

  # Add renderer to document
  stage.add-to-page!

  # Orbit camera
  #stage.camera.position <<< z: 200, x:200, y: -100
  stage.camera.position <<< z: 1200

  # Go
  stage.animate ->
    TWEEN.update!
    #root.rotation.y += 0.01
    stage.controller.update!
    stage.render!

  # Expose stop function
  window.stop = stage~stop

