
/*
 * Host package for three.js and the extensions I'm using
 *
 */

// Three.js - I've modified the source slightly to expose it as a module
var THREE = require('./threejs.min.js');

//console.group('ThreeJS::Load');
console.groupCollapsed('ThreeJS::Load');
console.log('ThreeJS::Load - version is', THREE.REVISION);

// Extensions - These depend on THREE, so delay init by exposing as an 'install' fn
//require('./color-gethsv.js').install(THREE);
//require('./update-color.ls').install(THREE);
require('./TrackballControls.js').install(THREE);

console.log('ThreeJS::Load - done.');
console.groupEnd();

// Return updated THREE with extensions attached
module.exports = THREE;

