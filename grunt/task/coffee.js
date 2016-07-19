/* jshint strict:false */

module.exports = {
  options: {
    join: true
  }, 
  
  "general": {
    files: {
      'dist/general/js/main.js': []
    }
  }, 
  
  "heart-walk": {
    files: {
      'dist/heart-walk/js/main.js': [
        'src/heart-walk/coffee/init.coffee', 
        'src/global/coffee/config/*.*', 
        'src/heart-walk/coffee/config/*.*', 
        'src/global/coffee/service/*.*', 
        'src/heart-walk/coffee/service/*.*', 
        'src/global/coffee/directive/*.*', 
        'src/heart-walk/coffee/directive/*.*', 
        'src/heart-walk/coffee/**/*.*'
      ]
    }
  }
}