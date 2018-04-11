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
      }, 
      {
        expand: true, 
        cwd: 'dist/heart-walk/css/', 
        src: [
          'participant.css'
        ], 
        dest: 'dist/heart-walk/css/'
      }, 
      {
        expand: true, 
        cwd: 'dist/heart-walk/css/', 
        src: [
          'pageEdit.css'
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
  }, 
  
  "high-school": {
    files: [
      {
        expand: true, 
        cwd: 'dist/high-school/css/', 
        src: [
          'main.css'
        ], 
        dest: 'dist/high-school/css/'
      }, 
      {
        expand: true, 
        cwd: 'dist/high-school/css/', 
        src: [
          'participant.css'
        ], 
        dest: 'dist/high-school/css/'
      }
    ]
  }, 
  
  "district-heart": {
    files: [
      {
        expand: true, 
        cwd: 'dist/district-heart/css/', 
        src: [
          'main.css'
        ], 
        dest: 'dist/district-heart/css/'
      }, 
      {
        expand: true, 
        cwd: 'dist/district-heart/css/', 
        src: [
          'participant.css'
        ], 
        dest: 'dist/district-heart/css/'
      }
    ]
  },

  "nchw": {
    files: [
      {
        expand: true,
        cwd: 'dist/nchw/css/',
        src: [
          'main.css'
        ],
        dest: 'dist/nchw/css/'
      }
    ]
  },

  "cyclenation": {
    files: [
      {
        expand: true,
        cwd: 'dist/cyclenation/css/',
        src: [
          'main.css'
        ],
        dest: 'dist/cyclenation/css/'
      }
    ]
  }
}