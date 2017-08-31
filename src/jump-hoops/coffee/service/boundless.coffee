angular.module 'ahaLuminateApp'
  .factory 'BoundlessService', [
    '$rootScope'
    '$http'
    '$sce'
    ($rootScope, $http, $sce) ->
      getBadges: (requestData) ->
        if $rootScope.tablePrefix is 'heartdev'
          url = 'AjaxProxy?cnv_url=' + encodeURIComponent('https://jumphoopsstaging.boundlessnetwork.com/api/badges/student/' + requestData) + '&auth=' + luminateExtend.global.ajaxProxyAuth
        else
          url = 'AjaxProxy?cnv_url=' + encodeURIComponent('https://jumphoops.heart.org/api/badges/student/' + requestData) + '&auth=' + luminateExtend.global.ajaxProxyAuth
        $http
          method: 'GET'
          url: url
          headers:
            'Content-Type': 'application/json'
      
      getRollupTotals: ->
        if $rootScope.tablePrefix is 'heartdev'
          url = 'https://jumphoopsstaging.boundlessnetwork.com/api/schools/totals/'
        else
          url = 'https://jumphoops.heart.org/api/schools/totals/'
        $http.jsonp($sce.trustAsResourceUrl(url), jsonpCallbackParam: 'callback')
          .then (response) ->
            response
          , (response) ->
            response
      
      logEmailSent: ->
        if $rootScope.tablePrefix is 'heartdev'
          url = 'AjaxProxy?cnv_url=' + encodeURIComponent('https://jumphoopsstaging.boundlessnetwork.com/api/webhooks/student/emails-sent/' + $rootScope.frId + '/' + $rootScope.consId) + '&auth=' + luminateExtend.global.ajaxProxyAuth
        else
          url = 'AjaxProxy?cnv_url=' + encodeURIComponent('https://jumphoops.heart.org/api/webhooks/student/emails-sent/' + $rootScope.frId + '/' + $rootScope.consId) + '&auth=' + luminateExtend.global.ajaxProxyAuth
        $http
          method: 'POST'
          url: url
          headers:
            'Content-Type': 'application/json'
      
      logPersonalPageUpdated: ->
        if $rootScope.tablePrefix is 'heartdev'
          url = 'AjaxProxy?cnv_url=' + encodeURIComponent('https://jumphoopsstaging.boundlessnetwork.com/api/webhooks/student/personal-page-updated/' + $rootScope.frId + '/' + $rootScope.consId) + '&auth=' + luminateExtend.global.ajaxProxyAuth
        else
          url = 'AjaxProxy?cnv_url=' + encodeURIComponent('https://jumphoops.heart.org/api/webhooks/student/personal-page-updated/' + $rootScope.frId + '/' + $rootScope.consId) + '&auth=' + luminateExtend.global.ajaxProxyAuth
        $http
          method: 'POST'
          url: url
          headers:
            'Content-Type': 'application/json'
  ]