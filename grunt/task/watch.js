/* jshint strict:false */

require('events').EventEmitter.prototype._maxListeners = 100;

module.exports = {
  "grunt-config": {
    files: [
      'Gruntfile.coffee', 
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
      'css-dist:general', 
      'js-dist:general', 
      'html-dist:general', 
      'img-copy:general-images', 
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
      'css-dist:heart-walk', 
      'js-dist:heart-walk', 
      'html-dist:heart-walk', 
      'img-copy:heart-walk-images', 
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
      'img-copy:youth-markets-images', 
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
      'js-dist:jump-hoops', 
      'html-dist:jump-hoops', 
      'img-copy:jump-hoops-images', 
      'notify:jump-hoops'
    ]
  }
}