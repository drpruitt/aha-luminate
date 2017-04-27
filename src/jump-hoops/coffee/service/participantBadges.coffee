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

      getRollupTotals: (requestData) ->
        url = 'AjaxProxy?cnv_url=' + encodeURIComponent('https://jumphoopsstaging.boundlessnetwork.com/api/badges/student/3196745') + '&auth=' + luminateExtend.global.ajaxProxyAuth       
        $http
          method: 'GET'
          url: url 
          headers:
            'Content-Type': 'application/json'
        .then (response) ->
          response
  ]

