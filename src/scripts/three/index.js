
/*
 * Host package for three.js and the extensions I'm using
 *
 */

// Three.js - I've modified the source slightly to expose it as a module
var THREE = require('./threejs.min.js');

console.groupCollapsed('ThreeJS::Load');
console.log('ThreeJS::Load - version is', THREE.REVISION);

// Extensions - These depend on THREE, so delay init by exposing as an 'install' fn
var cssRenderer       = require('./css-renderer.js');
var trackballControls = require('./trackball-controls.js');

// Expose extensions to the THREE object
cssRenderer.install(THREE);
trackballControls.install(THREE);

console.log('ThreeJS::Load - done.');
console.groupEnd();

// Return updated THREE with extensions attached
module.exports = THREE;

