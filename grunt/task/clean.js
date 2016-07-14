/* jshint strict:false */

module.exports = {
  "general": {
    files: [
      {
        expand: true, 
        cwd: 'dist/general/html/', 
        src: [
          '**/*'
        ]
      }, 
      {
        expand: true, 
        cwd: 'dist/general/image/', 
        src: [
          '**/*'
        ]
      }, 
      {
        expand: true, 
        cwd: 'dist/general/css/', 
        src: [
          '**/*'
        ]
      }, 
      {
        expand: true, 
        cwd: 'dist/general/js/', 
        src: [
          '**/*'
        ]
      }
    ]
  }, 
  
  "heart-walk": {
    files: [
      {
        expand: true, 
        cwd: 'dist/heart-walk/html/', 
        src: [
          '**/*'
        ]
      }, 
      {
        expand: true, 
        cwd: 'dist/heart-walk/image/', 
        src: [
          '**/*'
        ]
      }, 
      {
        expand: true, 
        cwd: 'dist/heart-walk/css/', 
        src: [
          '**/*'
        ]
      }, 
      {
        expand: true, 
        cwd: 'dist/heart-walk/js/', 
        src: [
          '**/*'
        ]
      }
    ]
  }
}