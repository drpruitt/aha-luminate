/* jshint strict:false */

module.exports = {
  options: {
    min: true
  }, 
  
  "jump-hoops-css-main": {
    options: {
      starttag: '<!-- jump-hoops-css-injector:{{ext}} -->', 
      endtag: '<!-- jump-hoops-css-endinjector -->', 
      transform: function(filepath) {
        var timestamp = filepath.split('.')[1]; // Get the timestamp out of the filename
        return '<link rel="stylesheet" href="../[[?xx::x[[S80:dev_branch]]x::::[[S80:dev_branch]]/]]aha-luminate/dist/jump-hoops/css/main.' + timestamp + '[[?xtruex::x[[S80:debug]]x::::.min]].css">';
      }
    }, 
    files: {
      'src/jump-hoops/html/page-wrapper/head-styles.html': ['dist/jump-hoops/css/main.' + '<%= timestamp %>' + '.css']
    }
  },

  "jump-hoops-css-participant": {
    options: {
      starttag: '<!-- jump-hoops-participant-css-injector:{{ext}} -->', 
      endtag: '<!-- jump-hoops-participant-css-endinjector -->', 
      transform: function(filepath) {
        var timestamp = filepath.split('.')[1]; // Get the timestamp out of the filename
        return '<link rel="stylesheet" href="../[[?xx::x[[S80:dev_branch]]x::::[[S80:dev_branch]]/]]aha-luminate/dist/jump-hoops/css/participant.' + timestamp + '[[?xtruex::x[[S80:debug]]x::::.min]].css">';
      }
    }, 
    files: {
      'src/jump-hoops/html/page-wrapper/head-styles.html': ['dist/jump-hoops/css/participant.' + '<%= timestamp %>' + '.css']
    }
  },  
  
  "jump-hoops-js-main": {
    options: {
      starttag: '<!-- jump-hoops-js-injector:{{ext}} -->', 
      endtag: '<!-- jump-hoops-js-endinjector -->', 
      transform: function(filepath) {
        var timestamp = filepath.split('.')[1]; // Get the timestamp out of the filename
        return '<script src="../[[?xx::x[[S80:dev_branch]]x::::[[S80:dev_branch]]/]]aha-luminate/dist/jump-hoops/js/main.' + timestamp + '[[?xtruex::x[[S80:debug]]x::::.min]].js"></script>';
      }
    }, 
    files: {
      'src/jump-hoops/html/page-wrapper/body-scripts.html': ['dist/jump-hoops/js/main.' + '<%= timestamp %>' + '.js']
    }
  }, 
  
  "jump-hoops-js-participant": {
    options: {
      starttag: '<!-- jump-hoops-participant-js-injector:{{ext}} -->', 
      endtag: '<!-- jump-hoops-participant-js-endinjector -->', 
      transform: function(filepath) {
        var timestamp = filepath.split('.')[1]; // Get the timestamp out of the filename
        return '<script src="../[[?xx::x[[S80:dev_branch]]x::::[[S80:dev_branch]]/]]aha-luminate/dist/jump-hoops/js/participant.' + timestamp + '[[?xtruex::x[[S80:debug]]x::::.min]].js"></script>';
      }
    }, 
    files: {
      'src/jump-hoops/html/page-wrapper/body-scripts.html': ['dist/jump-hoops/js/participant.' + '<%= timestamp %>' + '.js']
    }
  }
}