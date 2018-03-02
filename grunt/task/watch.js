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
      'src/global/sass/**/*', 
      'src/global/coffee/**/*', 
      'src/global/html/**/*'
    ], 
    tasks: [
      'notify:global'
    ]
  }, 
  
  "general": {
    files: [
      'src/global/sass/**/*', 
      'src/global/coffee/**/*', 
      'src/global/html/**/*', 
      'src/general/sass/**/*', 
      'src/general/coffee/**/*', 
      'src/general/html/**/*', 
      'src/general/image/**/*'
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
      'translation-copy:heart-walk-translations', 
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
  }, 
  
  "middle-school": {
    files: [
      'src/youth-markets/sass/**/*', 
      'src/global/coffee/**/*', 
      'src/youth-markets/coffee/**/*', 
      'src/middle-school/html/**/*', 
      'src/middle-school/image/**/*', 
      'src/middle-school/sass/**/*', 
      'src/middle-school/coffee/**/*'
    ], 
    tasks: [
      'clean:middle-school',  
      'css-dist:middle-school', 
      'js-dist:middle-school', 
      'html-dist:middle-school', 
      'img-copy:middle-school-images', 
      'notify:middle-school'
    ]
  }, 
  
  "high-school": {
    files: [
      'src/youth-markets/sass/**/*', 
      'src/global/coffee/**/*', 
      'src/youth-markets/coffee/**/*', 
      'src/high-school/html/**/*', 
      'src/high-school/image/**/*', 
      'src/high-school/sass/**/*', 
      'src/high-school/coffee/**/*'
    ], 
    tasks: [
      'clean:high-school',  
      'css-dist:high-school', 
      'js-dist:high-school', 
      'html-dist:high-school', 
      'img-copy:high-school-images', 
      'notify:high-school'
    ]
  }, 
  
  "district-heart": {
    files: [
      'src/youth-markets/sass/**/*', 
      'src/global/coffee/**/*', 
      'src/youth-markets/coffee/**/*', 
      'src/district-heart/html/**/*', 
      'src/district-heart/image/**/*', 
      'src/district-heart/sass/**/*', 
      'src/district-heart/coffee/**/*'
    ], 
    tasks: [
      'clean:district-heart',  
      'css-dist:district-heart', 
      'js-dist:district-heart', 
      'html-dist:district-heart', 
      'img-copy:district-heart-images', 
      'notify:district-heart'
    ]
  },

  "nchw": {
    files: [
      'src/nchw/html/**/*',
      'src/nchw/image/**/*',
      'src/nchw/sass/**/*',
      'src/nchw/js/**/*'
    ],
    tasks: [
      'clean:nchw',
      'css-dist:nchw',
      'js-dist:nchw',
      'html-dist:nchw',
      'img-copy:nchw-images',
      'notify:nchw'
    ]
  }
}