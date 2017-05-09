angular.module 'ahaLuminateApp'
  .factory 'ParticipantBadgesService', [
    '$http'
    '$sce'
    ($http, $sce) ->            
      getBadges: (requestData) ->
        url = 'AjaxProxy?cnv_url=' + encodeURIComponent('https://jumphoopsstaging.boundlessnetwork.com/api/badges/student/' + requestData) + '&auth=' + luminateExtend.global.ajaxProxyAuth
        $http
          method: 'GET'
          url: url
          headers:
            'Content-Type': 'application/json'
        .then (response) ->
          response
      
      getRollupTotals: ->
        url = '/system/proxy.jsp?__proxyURL=' + encodeURIComponent('https://jumphoopsstaging.boundlessnetwork.com/api/schools/totals')
        $http
          method: 'GET'
          url: url
          headers:
            'Content-Type': 'application/json'
        .then (response) ->
          response
  ]