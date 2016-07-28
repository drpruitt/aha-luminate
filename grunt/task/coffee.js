/* jshint strict:false */

module.exports = {
  options: {
    join: true
  }, 
  
  "general": {
    files: {
      'dist/general/js/main.js': [
        'src/general/coffee/init.coffee', 
        'src/global/coffee/config/*.*', 
        'src/general/coffee/config/*.*', 
        'src/global/coffee/service/*.*', 
        'src/general/coffee/service/*.*', 
        'src/global/coffee/directive/*.*', 
        'src/general/coffee/directive/*.*', 
        'src/general/coffee/**/*.*'
      ]
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