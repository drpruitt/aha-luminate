module.exports = function(grunt) {
  'use strict';
  
  require('time-grunt')(grunt);
  
  var config = {
    timestamp: new Date().getTime()
  }, 
  loadConfig = function(path) {
    var glob = require('glob'), 
    object = {}, 
    key;
    glob.sync('*', {
      cwd: path
    }).forEach(function(option) {
      key = option.replace(/\.js$/, '');
      object[key] = require(path + option);
    });
    return object;
  }, 
  runTargetedTask = function(tasks, taskTarget) {
    if(taskTarget) {
      for(var i = 0; i < tasks.length; i++) {
        if(config[tasks[i]][taskTarget]) {
          tasks[i] += ':' + taskTarget;
        }
      }
    }
    grunt.task.run(tasks);
  };
  
  grunt.util._.extend(config, loadConfig('./grunt/task/'));
  grunt.initConfig(config);
  
  require('load-grunt-tasks')(grunt);
  
  grunt.registerTask('html-dist', function(taskTarget) {
    runTargetedTask(['replace', 'htmlmin'], taskTarget);
  });
  grunt.registerTask('img-copy', function(taskTarget) {
    runTargetedTask(['copy'], taskTarget);
  });
  grunt.registerTask('img-dist', function(taskTarget) {
    runTargetedTask(['imagemin'], taskTarget);
  });
  grunt.registerTask('css-dist', function(taskTarget) {
    runTargetedTask(['sass', 'postcss', 'cssmin'], taskTarget);
  });
  grunt.registerTask('js-dist', function(taskTarget) {
    runTargetedTask(['coffee', 'uglify'], taskTarget);
  });
  grunt.registerTask('build', function() {
    runTargetedTask(['clean', 'sass', 'postcss', 'cssmin', 'coffee', 'uglify', 'replace', 'htmlmin', 'imagemin'], 'general');
    runTargetedTask(['clean', 'sass', 'postcss', 'cssmin', 'coffee', 'uglify', 'replace', 'htmlmin', 'imagemin'], 'heart-walk');
    runTargetedTask(['clean', 'replace', 'htmlmin', 'imagemin'], 'youth-markets');
    runTargetedTask(['clean', 'sass', 'postcss', 'cssmin', 'coffee', 'uglify', 'replace', 'htmlmin', 'imagemin'], 'jump-hoops');
  });
  grunt.registerTask('default', ['watch']);
};