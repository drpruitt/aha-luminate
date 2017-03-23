/* jshint strict:false */

module.exports = {
  "general-images": {
    files: [{
      expand: true, 
      cwd: 'src/general/image/', 
      src: [
        '*.{gif,GIF,jpg,JPG,png,PNG,svg,SVG}'
      ], 
      dest: 'dist/general/image/'
    }]
  }, 
  
  "heart-walk-images": {
    files: [{
      expand: true, 
      cwd: 'src/heart-walk/image/', 
      src: [
        '*.{gif,GIF,jpg,JPG,png,PNG,svg,SVG}'
      ], 
      dest: 'dist/heart-walk/image/'
    }]
  }, 
  
  "youth-markets-images": {
    files: [{
      expand: true, 
      cwd: 'src/youth-markets/image/', 
      src: [
        '*.{gif,GIF,jpg,JPG,png,PNG,svg,SVG}'
      ], 
      dest: 'dist/youth-markets/image/'
    }]
  }, 
  
  "jump-hoops-images": {
    files: [{
      expand: true, 
      cwd: 'src/jump-hoops/image/', 
      src: [
        '*.{gif,GIF,jpg,JPG,png,PNG,svg,SVG}'
      ], 
      dest: 'dist/jump-hoops/image/'
    }]
  }
}