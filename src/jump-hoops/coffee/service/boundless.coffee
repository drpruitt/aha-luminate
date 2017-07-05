angular.module 'ahaLuminateApp'
  .factory 'BoundlessService', [
    '$http'
    '$sce'
    ($http, $sce) ->
      getBadges: (requestData) ->
        if luminateExtend.global.tablePrefix is 'heartdev'
          url = 'AjaxProxy?cnv_url=' + encodeURIComponent('https://jumphoopsstaging.boundlessnetwork.com/api/badges/student/' + requestData) + '&auth=' + luminateExtend.global.ajaxProxyAuth
        else
          url = 'AjaxProxy?cnv_url=' + encodeURIComponent('https://jumphoops.heart.org/api/badges/student/' + requestData) + '&auth=' + luminateExtend.global.ajaxProxyAuth
        $http
          method: 'GET'
          url: url
          headers:
            'Content-Type': 'application/json'
        .then (response) ->
          response
      
      getRollupTotals: ->
        if luminateExtend.global.tablePrefix is 'heartdev'
          url = '/system/proxy.jsp?__proxyURL=' + encodeURIComponent('https://jumphoopsstaging.boundlessnetwork.com/api/schools/totals')
        else
          url = '/system/proxy.jsp?__proxyURL=' + encodeURIComponent('https://jumphoops.heart.org/api/schools/totals')
        $http
          method: 'GET'
          url: url
          headers:
            'Content-Type': 'application/json'
        .then (response) ->
          response
  ]