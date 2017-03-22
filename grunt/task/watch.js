/* jshint strict:false */

require('events').EventEmitter.prototype._maxListeners = 100;

module.exports = {
  "grunt-config": {
    files: [
      'Gruntfile.js', 
      'grunt/task/*.js', 
      'grunt/.jshintrc'
    ], 
    tasks: [
      'jshint:grunt-config', 
      'notify:grunt-config'
    ]
  }, 
  
  "global": {
    files: [
      'src/global/html/**/*', 
      'src/global/sass/**/*', 
      'src/global/coffee/**/*'
    ], 
    tasks: [
      'notify:global'
    ]
  }, 
  
  "general": {
    files: [
      'src/global/html/**/*', 
      'src/global/sass/**/*', 
      'src/global/coffee/**/*', 
      'src/general/html/**/*', 
      'src/general/image/**/*', 
      'src/general/sass/**/*', 
      'src/general/coffee/**/*'
    ], 
    tasks: [
      'clean:general', 
      'html-dist:general', 
      'img-dist:general', 
      'css-dist:general', 
      'js-dist:general', 
      'notify:general'
    ]
  }, 
  
  "heart-walk": {
    files: [
      'src/global/html/**/*', 
      'src/global/sass/**/*', 
      'src/global/coffee/**/*', 
      'src/heart-walk/html/**/*', 
      'src/heart-walk/image/**/*', 
      'src/heart-walk/sass/**/*', 
      'src/heart-walk/coffee/**/*'
    ], 
    tasks: [
      'clean:heart-walk', 
      'html-dist:heart-walk', 
      'img-dist:heart-walk', 
      'css-dist:heart-walk', 
      'js-dist:heart-walk', 
      'notify:heart-walk'
    ]
  }, 
  
  "youth-markets": {
    files: [
      'src/youth-markets/html/**/*', 
      'src/youth-markets/image/**/*'
    ], 
    tasks: [
      'clean:youth-markets', 
      'html-dist:youth-markets', 
      'img-dist:youth-markets', 
      'notify:youth-markets'
    ]
  }, 
  
  "jump-hoops": {
    files: [
      'src/youth-markets/sass/**/*', 
      'src/global/coffee/**/*', 
      'src/youth-markets/coffee/**/*', 
      'src/jump-hoops/html/**/*', 
      'src/jump-hoops/image/**/*', 
      'src/jump-hoops/sass/**/*', 
      'src/jump-hoops/coffee/**/*'
    ], 
    tasks: [
      'clean:jump-hoops',  
      'css-dist:jump-hoops', 
      'inject:jump-hoops-css-main',
      'inject:jump-hoops-css-participant',
      'js-dist:jump-hoops', 
      'inject:jump-hoops-js-main',
      'inject:jump-hoops-js-participant',
      'html-dist:jump-hoops', 
      'img-dist:jump-hoops',
      'notify:jump-hoops'
    ]
  }
}