/* jshint strict:false */

module.exports = {
  options: {
    join: true
  }, 
  
  "general": {
    files: {
      'dist/general/js/main.js': [
        'src/general/coffee/**/*.*'
      ]
    }
  }, 
  
  "heart-walk": {
    files: {
      'dist/heart-walk/js/main.js': [
        'src/heart-walk/coffee/**/*.*'
      ]
    }
  }
}