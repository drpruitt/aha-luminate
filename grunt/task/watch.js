/* jshint strict:false */

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
  }
}