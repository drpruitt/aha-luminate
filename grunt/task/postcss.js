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
    files: [{
      expand: true, 
      cwd: 'dist/general/css/', 
      src: [
        'main.css'
      ], 
      dest: 'dist/general/css/'
    }]
  }, 
  
  "heart-walk": {
    files: [{
      expand: true, 
      cwd: 'dist/heart-walk/css/', 
      src: [
        'main.css'
      ], 
      dest: 'dist/heart-walk/css/'
    }]
  }
}