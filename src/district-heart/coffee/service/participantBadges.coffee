angular.module 'ahaLuminateApp'
  .factory 'ParticipantBadgesService', [
    '$http'
    '$sce'
    ($http, $sce) ->            
      getBadges: (requestData) ->
        if luminateExtend.global.tablePrefix is 'heartdev'
          url = 'AjaxProxy?cnv_url=' + encodeURIComponent('https://districtheartchallengestaging.boundlessnetwork.com/api/badges/student/' + requestData) + '&auth=' + luminateExtend.global.ajaxProxyAuth
        else
          url = 'AjaxProxy?cnv_url=' + encodeURIComponent('https://districtheartchallenge.heart.org/api/badges/student/' + requestData) + '&auth=' + luminateExtend.global.ajaxProxyAuth
        $http
          method: 'GET'
          url: url
          headers:
            'Content-Type': 'application/json'
        .then (response) ->
          response
      
      getRollupTotals: ->
        url = '/system/proxy.jsp?__proxyURL=' + encodeURIComponent('https://districtheartchallenge.heart.org/api/schools/totals')
        $http
          method: 'GET'
          url: url
          headers:
            'Content-Type': 'application/json'
        .then (response) ->
          response

      getSchoolRollupTotals: (requestData) ->
        if luminateExtend.global.tablePrefix is 'heartdev'
          url = 'AjaxProxy?cnv_url=' + encodeURIComponent('https://thegreatreplaystaging.boundlessnetwork.com/api/schools/totals/' + requestData) + '&auth=' + luminateExtend.global.ajaxProxyAuth
        else
          url = 'AjaxProxy?cnv_url=' + encodeURIComponent('https://thegreatreplay.heart.org/api/schools/totals/' + requestData) + '&auth=' + luminateExtend.global.ajaxProxyAuth
        $http
          method: 'GET'
          url: url
          headers:
            'Content-Type': 'application/json'
        .then (response) ->
          response

  ]