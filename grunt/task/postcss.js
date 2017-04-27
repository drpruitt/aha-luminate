/* jshint strict:false */

module.exports = {
  options: {
    processors: [
      require('autoprefixer')({
        browsers: [
          'last 2 versions', 
          'ie >= 9', 
          'Safari >= 7', 
          'ios_saf >= 7'
        ]
      })
    ]
  }, 
  
  "general": {
    files: [
      {
        expand: true, 
        cwd: 'dist/general/css/', 
        src: [
          'main.css'
        ], 
        dest: 'dist/general/css/'
      }
    ]
  }, 
  
  "heart-walk": {
    files: [
      {
        expand: true, 
        cwd: 'dist/heart-walk/css/', 
        src: [
          'main.css'
        ], 
        dest: 'dist/heart-walk/css/'
      }
    ]
  }, 
  
  "jump-hoops": {
    files: [
      {
        expand: true, 
        cwd: 'dist/jump-hoops/css/', 
        src: [
          'main.css'
        ], 
        dest: 'dist/jump-hoops/css/'
      }, 
      {
        expand: true, 
        cwd: 'dist/jump-hoops/css/', 
        src: [
          'participant.css'
        ], 
        dest: 'dist/jump-hoops/css/'
      }
    ]
  }, 
  
  "middle-school": {
    files: [
      {
        expand: true, 
        cwd: 'dist/middle-school/css/', 
        src: [
          'main.css'
        ], 
        dest: 'dist/middle-school/css/'
      }, 
      {
        expand: true, 
        cwd: 'dist/middle-school/css/', 
        src: [
          'participant.css'
        ], 
        dest: 'dist/middle-school/css/'
      }
    ]
  }
}