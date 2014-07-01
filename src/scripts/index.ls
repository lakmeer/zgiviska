
# Require

THREE = require \three-js
TWEEN = require \tween

require \css-renderer .install THREE


# Helpers

id  = -> it
log = -> console.log.apply console, &; &0


# Internal state

camera   = new THREE.PerspectiveCamera( 40, window.innerWidth / window.innerHeight, 1, 10000 );
scene    = new THREE.Scene();
renderer = new THREE.CSS3DRenderer();


# Element types

Basic = ->
  element = document.createElement( 'div' )
  element.className = "greeble"
  element.style.opacity = 0.5 + Math.random! / 2
  element.style.backgroundColor = random-rgb!
  new THREE.CSS3DObject( element );


# Scene description

layout = require \./layout.ls


# Methods

random-from = (list) -> list[ Math.floor Math.random! * list.length ]

random-int = (n) -> Math.floor Math.random! * n

random-rgb = -> "rgb(#{random-int 255},#{random-int 255},#{random-int 255})"

random-position = (n) ->
  x : Math.random! * 2 * n - n
  y : Math.random! * 2 * n - n
  z : Math.random! * 2 * n - n

create-with-random-position = (Ctor, d) ->
  object = Ctor!
  object.position = random-position d
  return object

create-sphere-targets = (r, n) ->
  vector = new THREE.Vector3!   # Just a reusable helper

  for i from 0 to n
    p = Math.acos -1 + ( 2 * i ) / n
    θ = Math.sqrt( n * Math.PI ) * p
    target = new THREE.Object3D()

    target.position.x = r * (Math.cos θ) * (Math.sin p)
    target.position.y = r * (Math.sin θ) * (Math.sin p)
    target.position.z = r * (Math.cos p)

    vector.copy( target.position ).multiplyScalar( 2 )
    target.lookAt( vector )
    target

vector-of = (source) ->
  x: source.x
  y: source.y
  z: source.z

transform = (objects, targets, duration = 500, on-update = id) ->

  TWEEN.removeAll!

  for object, i in objects
    target = targets[i]

    new TWEEN.Tween object.position
      .to     (vector-of target.position), Math.random! * duration + duration
      .easing TWEEN.Easing.Exponential.InOut
      .start!

    new TWEEN.Tween object.rotation
      .to     (vector-of target.rotation), Math.random! * duration + duration
      .easing TWEEN.Easing.Exponential.InOut
      .start!

  new TWEEN.Tween this
    .to {}, duration * 2
    .onUpdate on-update
    .start!


# Create scene

objects = [ create-with-random-position Basic, 800 for i from 0 to 100 ]
targets = create-sphere-targets 800, objects.length


# Prepare

camera.position.z = 3000

renderer.setSize window.innerWidth, window.innerHeight
renderer.domElement.style.position = 'absolute'

render = -> renderer.render scene, camera

animate = ->
  TWEEN.update!
  requestAnimationFrame animate


# Listeners

window.addEventListener \resize', ->
  camera.aspect = window.innerWidth / window.innerHeight
  camera.updateProjectionMatrix!
  renderer.setSize window.innerWidth, window.innerHeight
  render!


# Onready

window.onload = ->

  # Add elements to scene
  objects.map -> scene.add it

  # Add renderer to document
  document.body.appendChild( renderer.domElement );

  # Move elements into position
  transform objects, targets, 5000, render
  animate!


