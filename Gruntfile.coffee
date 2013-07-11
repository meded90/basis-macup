#global module:false

module.exports = (grunt) ->
  fnShowProps = (obj, objName) ->
    result = ""
    for i of obj # обращение к свойствам объекта по индексу
      result += objName + "." + i + " = " + obj[i] + "\n"
    grunt.log.writeln result
  grunt.initConfig
    sass:
      compile:
        files:
          "build/css/style.css": ["./sass/style.scss"]
      dev:
        options: # Target options
          style: "expanded"
          trace: true
        files:
          "css/style.css": "sass/style.scss"

    coffee:
      compile:
        files:
          "js/script.js": ["js/**/*.coffee"]

    connect:
      server:
        options:
          base: "./"
          keepalive: true
          port: 4000
          hostname: '*'
    bake:
      build:
        files:
          "page/main.html": "app/main.html"


    watch:
      files: [ "app/*" ],
      options:
        nospawn: true,
      task:  'bake:build'

#  grunt.event.on "watch", (action, filepath, target) ->
#    grunt.log.writeln  "a#{filepath}"
#    s = {}
#    s['dfa'+filepath] = filepath
#    grunt.config.set('alert',{files:{"page/main.html": "app/main.html"}})
#    grunt.config.set('bake.changed',{files:{"page/main.html": "app/main.html"}})
#    a = grunt.config()
##    fnShowProps   a.bake.changed.files , "bake"
#    grunt.task.run(["comaled"])
#    fnShowProps grunt.task , "run"


  # These plugins provide necessary tasks.
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-sass"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-connect"
  grunt.loadNpmTasks "grunt-bake"


  # Default task.
  grunt.registerTask "default", ["watch"]
  grunt.registerTask "run", ["connect:server"] # не выпиливай очень нужная веш
#  grunt.event.on "watch", (action, filepath) ->
#    grunt.config.set "bake:name:src", filepath
#    grunt.task.run(["bake:name"])
#    fnShowProps grunt.config.bake , 'bake'
