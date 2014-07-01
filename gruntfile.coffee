
loadAll = require 'load-grunt-tasks'

module.exports = (grunt) ->

  grunt.initConfig {
    less:
      'public/styles.css' : [ 'src/styles/index.less' ]

    connect:
      server:
        options:
          livereload: on
          hostname: 'localhost'
          port: 9876
          base: 'public'

    browserify:
      main:
        options: transform: [ 'liveify' ]
        files: 'public/main.js' : [ 'src/scripts/index.ls' ]

    watch:
      reload:
        options: livereload: on
        files: [ 'public/*' ]

      compile:
        files: [ 'src/scripts/**/*' ]
        tasks: [ 'browserify' ]

      styles:
        files: [ 'src/styles/**/*' ]
        tasks: [ 'less' ]
  }

  loadAll grunt

  grunt.registerTask 'build',   [ 'less', 'browserify' ]
  grunt.registerTask 'server',  [ 'build', 'connect', 'watch' ]
  grunt.registerTask 'default', [ 'build' ]

