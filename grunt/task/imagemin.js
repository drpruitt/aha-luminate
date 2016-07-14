/* jshint strict:false */

module.exports = {
  options: {
    optimizationLevel: 7
  }, 
  
  "general": {
    files: [{
      expand: true, 
      cwd: 'src/general/image/', 
      src: [
        '*.{gif,GIF,jpg,JPG,png,PNG,svg,SVG}'
      ], 
      dest: 'dist/general/image/'
    }]
  }, 
  
  "heart-walk": {
    files: [{
      expand: true, 
      cwd: 'src/heart-walk/image/', 
      src: [
        '*.{gif,GIF,jpg,JPG,png,PNG,svg,SVG}'
      ], 
      dest: 'dist/heart-walk/image/'
    }]
  }
}