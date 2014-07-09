
# Require

THREE = require \three-js


# Set up stage

camera     = new THREE.PerspectiveCamera 40, (window.innerWidth / window.innerHeight), 1, 10000
scene      = new THREE.Scene
renderer   = new THREE.WebGLRenderer antialias: on
controller = new THREE.TrackballControls camera
origin     = new THREE.Object3D


# Allow canvas to respond to window

establish-sizes = ->
  w = window.innerWidth
  h = window.innerHeight
  camera.aspect = w / h
  camera.updateProjectionMatrix!
  renderer.set-size w, h

window.add-event-listener \resize, establish-sizes


# Rendering control

tick-fn = id

animate = (fn) ->
  tick-fn := ->
    fn!
    requestAnimationFrame tick-fn
  tick-fn!

stop = -> tick-fn := id

render = -> renderer.render scene, camera


# Constructor

Stage = ->

  establish-sizes!

  scene.fog = new THREE.Fog 0x000000, 1500, 10000

  add-to-page = -> document.body.appendChild( renderer.dom-element );

  { add-to-page, render, animate, camera, controller, origin, stop, add: scene~add }


# Export

module.exports = Stage

