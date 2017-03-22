/* jshint strict:false */

module.exports = {
  options: {
    noAdvanced: true
  }, 
  
  "general": {
    files: [
      {
        src: 'dist/general/css/main.css', 
        dest: 'dist/general/css/main.'+ '<%= timestamp %>' +'.min.css'
      }
    ]
  }, 
  
  "heart-walk": {
    files: [
      {
        src: 'dist/heart-walk/css/main.css', 
        dest: 'dist/heart-walk/css/main.'+ '<%= timestamp %>' +'.min.css'
      }
    ]
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