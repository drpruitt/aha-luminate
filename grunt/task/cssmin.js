/* jshint strict:false */

module.exports = {
  options: {
    noAdvanced: true
  }, 
  
  "general": {
    files: {
      'dist/general/css/main.min.css': [
        'dist/general/css/main.css'
      ]
    }
  }, 
  
  "heart-walk": {
    files: {
      'dist/heart-walk/css/main.min.css': [
        'dist/heart-walk/css/main.css'
      ]
    }
  }, 
  
  "jump-hoops": {
    files: [
      {
        src: 'dist/jump-hoops/css/main.css', 
        dest: 'dist/jump-hoops/css/main.'+ '<%= timestamp %>' +'.min.css'
      }, 
      {
        src: 'dist/jump-hoops/css/participant.css', 
        dest: 'dist/jump-hoops/css/participant.'+'<%= timestamp %>'+'.min.css'
      }
    ]
  }
}