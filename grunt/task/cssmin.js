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

  "jump-hoops-main": {
    src: 'dist/jump-hoops/css/main.css',
    dest: 'dist/jump-hoops/css/main.'+ '<%= timestamp %>' +'.min.css'
  },

  "jump-hoops-participant" : {
    src: 'dist/jump-hoops/css/participant.css',
    dest: 'dist/jump-hoops/css/participant.'+'<%= timestamp %>'+'.min.css'
  }
  
  /*"jump-hoops": {
    files: {
      'dist/jump-hoops/css/main.'+ <%= timestamp %> +'.min.css': [
        'dist/jump-hoops/css/main.css'
      ], 
      'dist/jump-hoops/css/participant.'+'<%= timestamp %>'+'.min.css': [
        'dist/jump-hoops/css/participant.css'
      ]
    }
  }*/
}