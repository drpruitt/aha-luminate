angular.module 'ahaLuminateApp'
  .factory 'ParticipantBadgesService', [
    '$http'
    '$sce'
    ($http, $sce) ->            
      getBadges: (requestData) ->
        url = 'AjaxProxy?cnv_url=https://jumphoopsstaging.boundlessnetwork.com/api/badges/student/' +requestData+ '&auth=' + luminateExtend.global.ajaxProxyAuth       
        $http
          method: 'GET'
          url: url 
          headers:
            'Content-Type': 'application/json'
        .then (response) ->
          response

      getRollupTotals: ->
        url = 'http://heart.pub30.convio.net/system/proxy.jsp?__proxyURL=https://jumphoopsstaging.boundlessnetwork.com/api/schools/totals'
        $http
          method: 'GET'
          url: url 
          headers:
            'Content-Type': 'application/json'
        .then (response) ->
          response

  ]

