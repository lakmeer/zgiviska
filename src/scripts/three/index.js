
/*
 * Host package for three.js and the extensions I'm using
 *
 */

// Three.js - I've modified the source slightly to expose it as a module
var THREE = require('./threejs.min.js');

console.groupCollapsed('ThreeJS::Load');
console.log('ThreeJS::Load - version is', THREE.REVISION);

// Extensions - These depend on THREE, so delay init by exposing as an 'install' fn
var cssRenderer       = require('./CssRenderer.js');
var trackballControls = require('./TrackballControls.js');
// var effectComposer    = require('./EffectComposer.js');
// var renderPass        = require('./RenderPass.js');
// var shaderPass        = require('./ShaderPass.js');

// Expose extensions to the THREE object
cssRenderer.install(THREE);
trackballControls.install(THREE);
// effectComposer.install(THREE);
// renderPass.install(THREE);
// shaderPass.install(THREE);

console.log('ThreeJS::Load - done.');
console.groupEnd();

// Return updated THREE with extensions attached
module.exports = THREE;

