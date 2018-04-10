/* jshint strict:false */

module.exports = {
  options: {
    optimizationLevel: 7
  }, 
  
  "general": {
    files: [
      {
        expand: true, 
        cwd: 'src/general/image/', 
        src: [
          '*.{gif,GIF,jpg,JPG,png,PNG,svg,SVG}'
        ], 
        dest: 'dist/general/image/'
      }
    ]
  }, 
  
  "heart-walk": {
    files: [
      {
        expand: true, 
        cwd: 'src/heart-walk/image/', 
        src: [
          '*.{gif,GIF,jpg,JPG,png,PNG,svg,SVG}'
        ], 
        dest: 'dist/heart-walk/image/'
      }
    ]
  }, 
  
  "youth-markets": {
    files: [
      {
        expand: true, 
        cwd: 'src/youth-markets/image/', 
        src: [
          '*.{gif,GIF,jpg,JPG,png,PNG,svg,SVG}'
        ], 
        dest: 'dist/youth-markets/image/'
      }
    ]
  }, 
  
  "jump-hoops": {
    files: [
      {
        expand: true, 
        cwd: 'src/jump-hoops/image/', 
        src: [
          '*.{gif,GIF,jpg,JPG,png,PNG,svg,SVG}'
        ], 
        dest: 'dist/jump-hoops/image/'
      }
    ]
  }, 
  
  "middle-school": {
    files: [
      {
        expand: true, 
        cwd: 'src/middle-school/image/', 
        src: [
          '*.{gif,GIF,jpg,JPG,png,PNG,svg,SVG}'
        ], 
        dest: 'dist/middle-school/image/'
      }
    ]
  }, 
  
  "high-school": {
    files: [
      {
        expand: true, 
        cwd: 'src/high-school/image/', 
        src: [
          '*.{gif,GIF,jpg,JPG,png,PNG,svg,SVG}'
        ], 
        dest: 'dist/high-school/image/'
      }
    ]
  }, 
  
  "district-heart": {
    files: [
      {
        expand: true, 
        cwd: 'src/district-heart/image/', 
        src: [
          '*.{gif,GIF,jpg,JPG,png,PNG,svg,SVG}'
        ], 
        dest: 'dist/district-heart/image/'
      }
    ]
  },

  "nchw": {
    files: [
      {
        expand: true,
        cwd: 'src/nchw/image/',
        src: [
          '*.{gif,GIF,jpg,JPG,png,PNG,svg,SVG}'
        ],
        dest: 'dist/nchw/image/'
      }
    ]
  }
}