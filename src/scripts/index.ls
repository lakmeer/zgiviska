
# Require

THREE = require \three-js
TWEEN = require \tween-js
require! './helpers.ls'

Stage    = require \./stage.ls
Greebles = require \./greebles/index.ls
Key      = require \./keycodes.ls

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

left-buttons  = Greebles.ButtonArray 'Left  wand button array', [ 1, 2, 4, 3 ]
right-buttons = Greebles.ButtonArray 'Right wand button array', [ 1, 2, 4, 3 ]

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

  # Inspect specific elements
  inspect-target = right-stick

  # Add renderer to document
  stage.add-to-page!

  stage.camera.position.z = 1200
  #stage.camera.position = inspect-target.position.clone!
  #stage.camera.position.z += 500
  #stage.controller.target = inspect-target.position.clone!
  #stage.controller.target.y += 100

  # Go
  stage.animate ->
    TWEEN.update!
    #inspect-target.rotation.y += 0.02
    stage.controller.update!
    stage.render!

  # Expose stop function
  window.stop = stage~stop


  # Key toggle
  key-toggle = (direction, { which }) -->
    switch which
    | Key.TILDE => left-home.set-active direction
    | Key.NUM_1 => left-buttons.set-active  0, direction
    | Key.NUM_2 => left-buttons.set-active  1, direction
    | Key.NUM_3 => left-buttons.set-active  2, direction
    | Key.NUM_4 => left-buttons.set-active  3, direction
    | Key.NUM_5 => right-buttons.set-active 0, direction
    | Key.NUM_6 => right-buttons.set-active 1, direction
    | Key.NUM_7 => right-buttons.set-active 2, direction
    | Key.NUM_8 => right-buttons.set-active 3, direction
    | Key.NUM_9 => right-home.set-active direction
    | Key.Q => right-stick.set-octant (if direction then 1 else 0)
    | Key.W => right-stick.set-octant (if direction then 2 else 0)
    | Key.E => right-stick.set-octant (if direction then 3 else 0)
    | Key.R => right-stick.set-octant (if direction then 4 else 0)
    | Key.T => right-stick.set-octant (if direction then 5 else 0)
    | Key.Y => right-stick.set-octant (if direction then 6 else 0)
    | Key.U => right-stick.set-octant (if direction then 7 else 0)
    | Key.I => right-stick.set-octant (if direction then 8 else 0)
    | _  => log "Key unassigned:", which


  # Add keyboard listeners for testing interaction
  document.add-event-listener \keydown, key-toggle on
  document.add-event-listener \keyup, key-toggle off

