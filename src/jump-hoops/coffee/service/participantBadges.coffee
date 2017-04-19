angular.module 'ahaLuminateApp'
  .factory 'ParticipantBadgesService', [
    '$http'
    '$sce'
    ($http, $sce) ->      
      getAuth: ->
        url = 'https://jumphoopsstaging.boundlessnetwork.com/api/login/'
        urlSCE = $sce.trustAsResourceUrl url
        urlSCEparse = $sce.parseAsResourceUrl urlSCE

        $http
          method: 'POST'
          url: 'AjaxProxy?auth=' + luminateExtend.global.ajaxProxyAuth + '&cnv_url=' + encodeURIComponent(url)
          auth_key: 'lxDH5IaQiUBfpqfYAN7jOn7rD'
          public_key: '44dd74bf0136e3c451af98af63d8ef5f'
        .then (response) ->
          console.log response
        

      getBadges: (requestData) ->
        url = 'https://jumphoopsstaging.boundlessnetwork.com/api/coordinator/instant/student/'+requestData
        urlSCE = $sce.trustAsResourceUrl url
        $http
          method: 'POST',
          url: urlSCE



  ]