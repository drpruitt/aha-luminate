angular.module 'ahaLuminateApp'
  .factory 'BoundlessService', [
    '$http'
    '$sce'
    ($http, $sce) ->
      getBadges: (requestData) ->
        if luminateExtend.global.tablePrefix is 'heartdev'
          url = 'AjaxProxy?cnv_url=' + encodeURIComponent('https://aha-hs-staging.boundlessnetwork.com/api/badges/student/' + requestData) + '&auth=' + luminateExtend.global.ajaxProxyAuth
        else
          url = 'AjaxProxy?cnv_url=' + encodeURIComponent('https://aha-highschool.boundlessnetwork.com/api/badges/student/' + requestData) + '&auth=' + luminateExtend.global.ajaxProxyAuth
        $http
          method: 'GET'
          url: url
          headers:
            'Content-Type': 'application/json'
        .then (response) ->
          response
      
      getRollupTotals: ->
        if luminateExtend.global.tablePrefix is 'heartdev'
          url = '/system/proxy.jsp?__proxyURL=' + encodeURIComponent('https://aha-hs-staging.boundlessnetwork.com/api/schools/totals')
        else
          # url = '/system/proxy.jsp?__proxyURL=' + encodeURIComponent('https://aha-highschool.boundlessnetwork.com/api/schools/totals')
          url = '/system/proxy.jsp?__proxyURL=' + encodeURIComponent('https://aha-hs-staging.boundlessnetwork.com/api/schools/totals')
        $http
          method: 'GET'
          url: url
          headers:
            'Content-Type': 'application/json'
        .then (response) ->
          response
      
      getSchoolRollupTotals: (requestData) ->
        if luminateExtend.global.tablePrefix is 'heartdev'
          url = 'AjaxProxy?cnv_url=' + encodeURIComponent('https://aha-hs-staging.boundlessnetwork.com/api/schools/totals/' + requestData) + '&auth=' + luminateExtend.global.ajaxProxyAuth
        else
          url = 'AjaxProxy?cnv_url=' + encodeURIComponent('https://aha-highschool.boundlessnetwork.com/api/schools/totals/' + requestData) + '&auth=' + luminateExtend.global.ajaxProxyAuth
        $http
          method: 'GET'
          url: url
          headers:
            'Content-Type': 'application/json'
        .then (response) ->
          response
  ]