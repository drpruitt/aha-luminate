/* jshint strict:false */

module.exports = {
  options: {
    join: true
  }, 
  
  "general": {
    files: {
      'dist/general/js/main.js': [
        'src/general/coffee/init.coffee', 
        'src/global/coffee/config/*.*', 
        'src/general/coffee/config/*.*', 
        'src/global/coffee/service/*.*', 
        '!src/global/coffee/service/trpc-*.*', 
        'src/general/coffee/service/*.*', 
        'src/global/coffee/directive/*.*', 
        'src/general/coffee/directive/*.*', 
        'src/general/coffee/**/*.*'
      ]
    }
  }, 
  
  "heart-walk": {
    files: {
      'dist/heart-walk/js/main.js': [
        'src/heart-walk/coffee/init.coffee', 
        'src/global/coffee/config/*.*', 
        'src/heart-walk/coffee/config/*.*', 
        'src/global/coffee/service/*.*', 
        '!src/global/coffee/service/trpc-*.*', 
        'src/heart-walk/coffee/service/*.*', 
        'src/global/coffee/directive/*.*', 
        'src/heart-walk/coffee/directive/*.*', 
        'src/heart-walk/coffee/**/*.*'
      ]
    }
  }, 
  
  "jump-hoops": {
    files: {
      'dist/jump-hoops/js/main.js': [
        'src/jump-hoops/coffee/init.coffee', 
        'src/jump-hoops/coffee/config/*.*', 
        '!src/jump-hoops/coffee/config/trpc-*.*', 
        'src/global/coffee/service/*.*', 
        '!src/global/coffee/service/trpc-*.*', 
        'src/jump-hoops/coffee/service/*.*', 
        '!src/jump-hoops/coffee/service/trpc-*.*', 
        'src/global/coffee/directive/*.*', 
        'src/jump-hoops/coffee/directive/*.*', 
        '!src/jump-hoops/coffee/directive/trpc-*.*', 
        'src/jump-hoops/coffee/**/*.*', 
        '!src/jump-hoops/coffee/**/trpc-*.*'
      ], 
      'dist/jump-hoops/js/participant.js': [
        'src/jump-hoops/coffee/trpc-init.coffee', 
        'src/jump-hoops/coffee/config/trpc-*.*', 
        'src/global/coffee/service/trpc-*.*', 
        'src/jump-hoops/coffee/**/trpc-*.*'
      ]
    }
  }, 
  
  "middle-school": {
    files: {
      'dist/middle-school/js/main.js': [
        'src/middle-school/coffee/init.coffee', 
        'src/middle-school/coffee/config/*.*', 
        '!src/middle-school/coffee/config/trpc-*.*', 
        'src/global/coffee/service/*.*', 
        '!src/global/coffee/service/trpc-*.*', 
        'src/middle-school/coffee/service/*.*', 
        '!src/middle-school/coffee/service/trpc-*.*', 
        'src/global/coffee/directive/*.*', 
        'src/middle-school/coffee/directive/*.*', 
        '!src/middle-school/coffee/directive/trpc-*.*', 
        'src/middle-school/coffee/**/*.*', 
        '!src/middle-school/coffee/**/trpc-*.*'
      ], 
      'dist/middle-school/js/participant.js': [
        'src/middle-school/coffee/trpc-init.coffee', 
        'src/middle-school/coffee/config/trpc-*.*', 
        'src/global/coffee/service/trpc-*.*', 
        'src/middle-school/coffee/**/trpc-*.*'
      ]
    }
  }
}