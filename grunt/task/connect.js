/* jshint strict:false */

module.exports = {
  options: {
    middleware: function(connect, options, defaultMiddleware) {
      var proxy = require('grunt-connect-proxy/lib/utils').proxyRequest;
      return [proxy].concat(defaultMiddleware);
    }
  }, 
  
  "dev": {
    proxies: [
      {
        context: '/nonsecure/site', 
        rewrite: {
          '^/nonsecure': ''
        }, 
        host: 'heartdev.convio.net', 
        secure: false, 
        headers: {
          'host': 'heartdev.convio.net'
        }
      }, 
      {
        context: '/secure/site', 
        rewrite: {
          '^/secure': '/heartdev'
        }, 
        host: 'secure3.convio.net', 
        port: 443, 
        https: true, 
        secure: false, 
        headers: {
          'host': 'secure3.convio.net'
        }
      }
    ]
  }
}