/* jshint strict:false */

module.exports = {
  options: {
    min: true
  }, 
  
  "general-css-main": {
    options: {
      template: 'src/general/html/page-wrapper/head-styles.html', 
      starttag: '<!-- general-css-injector:{{ext}} -->', 
      endtag: '<!-- general-css-endinjector -->', 
      transform: function(filepath) {
        var timestamp = filepath.split('.')[1]; // Get the timestamp out of the filename
        return '<link rel="stylesheet" href="../[[?xx::x[[S80:dev_branch]]x::::[[S80:dev_branch]]/]]aha-luminate/dist/general/css/main.' + timestamp + '[[?xtruex::x[[S80:debug]]x::::.min]].css">';
      }
    }, 
    files: {
      'src/general/html/page-wrapper/head-styles.html': [
        'dist/general/css/main.' + '<%= timestamp %>' + '.min.css'
      ]
    }
  }, 
  
  "general-js-main": {
    options: {
      template: 'src/general/html/page-wrapper/body-scripts.html', 
      starttag: '<!-- general-js-injector:{{ext}} -->', 
      endtag: '<!-- general-js-endinjector -->', 
      transform: function(filepath) {
        var timestamp = filepath.split('.')[1]; // Get the timestamp out of the filename
        return '<script src="../[[?xx::x[[S80:dev_branch]]x::::[[S80:dev_branch]]/]]aha-luminate/dist/general/js/main.' + timestamp + '[[?xtruex::x[[S80:debug]]x::::.min]].js"></script>';
      }
    }, 
    
    files: {
      'src/general/html/page-wrapper/body-scripts.html': [
        'dist/general/js/main.' + '<%= timestamp %>' + '.min.js'
      ]
    }
  }, 
  
  "jump-hoops-css-main": {
    options: {
      template: 'src/jump-hoops/html/page-wrapper/head-styles.html', 
      starttag: '<!-- jump-hoops-css-injector:{{ext}} -->', 
      endtag: '<!-- jump-hoops-css-endinjector -->', 
      transform: function(filepath) {
        var timestamp = filepath.split('.')[1]; // Get the timestamp out of the filename
        return '<link rel="stylesheet" href="../[[?xx::x[[S80:dev_branch]]x::::[[S80:dev_branch]]/]]aha-luminate/dist/jump-hoops/css/main.' + timestamp + '[[?xtruex::x[[S80:debug]]x::::.min]].css">';
      }
    }, 
    files: {
      'src/jump-hoops/html/page-wrapper/head-styles.html': [
        'dist/jump-hoops/css/main.' + '<%= timestamp %>' + '.min.css'
      ]
    }
  }, 
  
  "jump-hoops-css-participant": {
    options: {
      template: 'src/jump-hoops/html/page-wrapper/head-styles.html', 
      starttag: '<!-- jump-hoops-participant-css-injector:{{ext}} -->', 
      endtag: '<!-- jump-hoops-participant-css-endinjector -->', 
      transform: function(filepath) {
        var timestamp = filepath.split('.')[1]; // Get the timestamp out of the filename
        return '<link rel="stylesheet" href="../[[?xx::x[[S80:dev_branch]]x::::[[S80:dev_branch]]/]]aha-luminate/dist/jump-hoops/css/participant.' + timestamp + '[[?xtruex::x[[S80:debug]]x::::.min]].css">';
      }
    }, 
    files: {
      'src/jump-hoops/html/page-wrapper/head-styles.html': [
        'dist/jump-hoops/css/participant.' + '<%= timestamp %>' + '.min.css'
      ]
    }
  }, 
  
  "jump-hoops-js-main": {
    options: {
      template: 'src/jump-hoops/html/page-wrapper/body-scripts.html', 
      starttag: '<!-- jump-hoops-js-injector:{{ext}} -->', 
      endtag: '<!-- jump-hoops-js-endinjector -->', 
      transform: function(filepath) {
        var timestamp = filepath.split('.')[1]; // Get the timestamp out of the filename
        return '<script src="../[[?xx::x[[S80:dev_branch]]x::::[[S80:dev_branch]]/]]aha-luminate/dist/jump-hoops/js/main.' + timestamp + '[[?xtruex::x[[S80:debug]]x::::.min]].js"></script>';
      }
    }, 
    
    files: {
      'src/jump-hoops/html/page-wrapper/body-scripts.html': [
        'dist/jump-hoops/js/main.' + '<%= timestamp %>' + '.min.js'
      ]
    }
  }, 
  
  "jump-hoops-js-participant": {
    options: {
      template: 'src/jump-hoops/html/page-wrapper/body-scripts.html', 
      starttag: '<!-- jump-hoops-participant-js-injector:{{ext}} -->', 
      endtag: '<!-- jump-hoops-participant-js-endinjector -->', 
      transform: function(filepath) {
        var timestamp = filepath.split('.')[1]; // Get the timestamp out of the filename
        return '<script src="../[[?xx::x[[S80:dev_branch]]x::::[[S80:dev_branch]]/]]aha-luminate/dist/jump-hoops/js/participant.' + timestamp + '[[?xtruex::x[[S80:debug]]x::::.min]].js"></script>';
      }
    }, 
    files: {
      'src/jump-hoops/html/page-wrapper/body-scripts.html': [
        'dist/jump-hoops/js/participant.' + '<%= timestamp %>' + '.min.js'
      ]
    }
  }
}