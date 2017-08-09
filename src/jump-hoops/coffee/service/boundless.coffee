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
        .then (response) ->
          response
      
      getRollupTotals: ->
        url = $sce.trustAsResourceUrl('https://jumphoops.heart.org/api/schools/totals/')
        $http.jsonp(url, {jsonpCallbackParam: 'callback'}).then ((response) ->
          return response
        ), (response) ->
          console.log 'JSONP ERROR!'
          return response
  ]