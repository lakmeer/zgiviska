
# Require

THREE = require \three-js
TWEEN = require \tween-js


# Helpers

require! './helpers.ls'

SECONDS = 1000
MINUTES = 60 * SECONDS


# Settings

w = window.innerWidth
h = window.innerHeight

aspect      = w / h


# Internal state

camera     = new THREE.PerspectiveCamera 40, aspect, 1, 10000
scene      = new THREE.Scene
renderer   = new THREE.CSS3DRenderer


# Scene description

layout = require \./layout.ls


# Generators

random-from = (list) -> list[ Math.floor Math.random! * list.length ]
random-int  = (n) -> Math.floor Math.random! * n
random-rgb  = -> "rgb(#{random-int 255},#{random-int 255},#{random-int 255})"
random-rgb  = -> "rgb(127,127,127)"

random-position = (n) ->
  x : Math.random! * 2 * n - n
  y : Math.random! * 2 * n - n
  z : Math.random! * 2 * n - n


# Prepare

renderer.setSize window.innerWidth, window.innerHeight
renderer.domElement.style.position = 'absolute'

render = -> renderer.render scene, camera

animate = (fn) ->
  next = ->
    fn!
    requestAnimationFrame next
  next!

camera-orbit = (r) ->
  t = 0
  (Δt) ->
    t += Δt
    { x, z } = camera.position
    camera.position.x = r * Math.cos(t) + r * Math.sin(t)
    camera.position.z = r * Math.cos(t) - r * Math.sin(t)
    camera.lookAt scene.position


# Listeners

window.addEventListener \resize, ->
  camera.aspect = window.innerWidth / window.innerHeight
  camera.updateProjectionMatrix!
  renderer.setSize window.innerWidth, window.innerHeight
  render!


# Element types

E = (class-name = "") ->
  el = document.create-element \div
  el.class-name = class-name
  return el

Basic = (class-name = "") ->
  object = new THREE.CSS3DObject E class-name

Group = (cn = "", pos = { x: 0, y: 0 }) ->
  o = Basic "group #cn"
  o.position.x = pos.x
  o.position.y = pos.y
  return o

Graphic = (cn = "", size = { w: 0, h: 0 }) ->
  o = Basic "graphic #cn"
  o.element.width  = size.w
  o.element.height = size.h
  return o

Shape = (cn = "") ->
  Basic "shape #cn"

Greeble = (class-name = "") ->
  object = new THREE.CSS3DObject E "greeble #class-name"

Label = (text, cn = "") ->
  Text text, "greeble label " + cn

FancyLabel = (text, cn ="") ->
  Label text, "fancy-label #cn"

Text = (text, cn = "") ->
  el = E "text #cn"
  el.innerHTML = text
  object = new THREE.CSS3DObject el

Rotator = (n, height) ->
  speed = 30 * SECONDS
  rings = [ Greeble "ring-#{i+1}" for i from 0 til n ]
  group = new THREE.Object3D

  rings.map (ring, i) ->
    group.add ring
    ring.position.z = i * height/(n-1) - height/2
    random-rotation = if Math.random! > 0.5 then -tau else tau
    tween = new TWEEN.Tween ring.rotation .to { z : random-rotation }, Math.random! * speed/2 + speed/2
    tween.on-complete -> ring.rotation.z = 0; tween.start!
    tween.start!
  return group

Button = (text = 'button') ->
  object = Group "button active"
  frame  = Basic \button-frame
  text   = Text text, "button-text active"

  button-component-offset = 6
  frame.position.z += button-component-offset
  text.position.z  += button-component-offset

  object.add frame
  object.add text

  return object

ButtonArray = (name, texts) ->
  a = 19; b = 51
  button-coords = [ [ a, -b ], [ -a, -b ], [ a, b ], [ -a, b ] ]
  object = Greeble \button-array

  label = FancyLabel name, \button-array-label
  label.position.y = 45
  object.add label

  buttons = texts.map Button
  buttons.map (button, i) ->
    button.position.y = button-coords[i][0] - 16
    button.position.x = button-coords[i][1]
    object.add button

  return object

Digit = (name, value) ->
  group = Group \digit

  label = FancyLabel name, \digit-label
  label.position.y = 50
  group.add label

  text-container = Group \digit-text-container
  text-container.position.y = -11
  group.add text-container

  text = Text value, \digit-text
  text.position.z = 10
  text-container.add text

  return group

Hex = (name, digit) ->
  group = Group \hex

  layer-depths = [ 30, 0, 50 ]
  layers = [ Greeble "hex-#i" for i from 1 to 3 ]
  layers.map (x, i) -> x.position.z = layer-depths[i]; group.add x

  label = Label name, \hex-label
  label.position <<< { y: -90, z: 15 }
  group.add label

  text = Text digit, \hex-text
  group.add text

  return group

Octants = ->

  group = Group \octants

  layer-depths = [ 0, 10, 20, 80, 90 ]
  layers = [ Greeble "oct-#i" for i from 1 to 5 ]
  layers.map (x, i) -> x.position.z = layer-depths[i]; group.add x


  return group

# Create scene

root    = new THREE.Object3D

rotator = Rotator 5, 600
rotator.position.z = -450

hex = Hex \pitch, \F
hex.position.z = -50

left-stick  = Octants!
left-stick.position <<< { x: -520, y: -325 }

right-stick = Octants!
right-stick.position <<< { x: 520, y: -325 }

left-button-group  = Group \left-button-group  x: -250, y: -247
right-button-group = Group \right-button-group x:  250, y: -247

left-buttons  = ButtonArray 'Left  wand button array', [ 1, 2, 3, 4 ]
right-buttons = ButtonArray 'Right wand button array', [ 1, 2, 3, 4 ]

left-home = Button \home
left-home.position.y = -90

right-home = Button \home
right-home.position.y = -90

left-gfx  = Graphic \button-diagram,  { w: 303, h: 258 }
left-gfx.position <<< { x: -197, y: 38 }

right-gfx = Graphic \button-diagram, { w: 303, h: 258 }
right-gfx.position <<< { x: 197, y:38 }
right-gfx.rotation.y = pi

[ left-buttons
  left-home
  left-gfx
].map left-button-group~add

[ right-buttons
  right-home
  right-gfx
].map right-button-group~add

tonic  = Digit \root, \A
octave = Digit \octave, 2

tonic.position.x  =  -54
tonic.position.y  = -252
octave.position.x =   54
octave.position.y = -252


# Add all to scene

[ root
  rotator
  left-stick
  right-stick
  hex
  tonic
  octave
  left-button-group
  right-button-group
].map scene~add


camera.position.z = 1300


# Onready

window.onload = ->

  # Set up trackball
  controller = new THREE.TrackballControls camera

  # Add renderer to document
  document.body.appendChild( renderer.domElement );

  # Orbit camera
  update-camera = camera-orbit 800

  # Go
  animate ->
    TWEEN.update!
    controller.update!
    #update-camera 0.005
    render!

