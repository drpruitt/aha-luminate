/* jshint strict:false */

module.exports = {
  "general": {
    files: [
      {
        src: [
          'dist/general/js/main.js'
        ], 
        dest: 'dist/general/js/main.' + '<%= timestamp %>' + '.min.js'
      }
    ]
  }, 
  
  "heart-walk": {
    files: [
      {
        src: [
          'dist/heart-walk/js/main.js'
        ], 
        dest: 'dist/heart-walk/js/main.' + '<%= timestamp %>' + '.min.js'
      }, 
      {
        src: [
          'dist/heart-walk/js/participant.js'
        ], 
        dest: 'dist/heart-walk/js/participant.' + '<%= timestamp %>' + '.min.js'
      }
    ]
  }, 
  
  "jump-hoops": {
    files: [
      {
        src: [
          'dist/jump-hoops/js/main.js'
        ], 
        dest: 'dist/jump-hoops/js/main.' + '<%= timestamp %>' + '.min.js'
      }, 
      {
        src: [
          'dist/jump-hoops/js/participant.js'
        ], 
        dest: 'dist/jump-hoops/js/participant.' + '<%= timestamp %>' + '.min.js'
      }
    ]
  }, 
  
  "middle-school": {
    files: [
      {
        src: [
          'dist/middle-school/js/main.js'
        ], 
        dest: 'dist/middle-school/js/main.' + '<%= timestamp %>' + '.min.js'
      }, 
      {
        src: [
          'dist/middle-school/js/participant.js'
        ], 
        dest: 'dist/middle-school/js/participant.' + '<%= timestamp %>' + '.min.js'
      }
    ]
  }
}