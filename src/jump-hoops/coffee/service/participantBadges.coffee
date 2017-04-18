angular.module 'ahaLuminateApp'
  .factory 'ParticipantBadgesService', [
    '$http'
    '$sce'
    ($http, $sce) ->      
      ###
      getBadges: ->
        $http
          url: '../ym-dev/mock-badges.json'
      ###
      getAuth: ->
        console.log 'getauth'
        url = 'https://jumphoopsstaging.boundlessnetwork.com/api/validate/'
        urlSCE = $sce.trustAsResourceUrl url
        urlSCEparse = $sce.parseAsResourceUrl urlSCE

        $http
          method: 'JSONP'
          url: urlSCE
          auth_key: 'lxDH5IaQiUBfpqfYAN7jOn7rD'
          public_key: '44dd74bf0136e3c451af98af63d8ef5f'
          jsonpCallbackParam: 'callback'
        .then (response) ->
          console.log response
        ###
        $http.jsonp
          url: urlSCE 
          jsonpCallbackParam: 'callback'

        .then (response) ->
          if response.data.success is false
            callback.error response
          else
            callback.success response
        , (response) ->
          callback.error response
        ###


      getBadges: (requestData) ->
        url = 'https://jumphoopsstaging.boundlessnetwork.com/api/coordinator/instant/student/'+requestData
        urlSCE = $sce.trustAsResourceUrl url
        $http
          method: 'POST',
          url: urlSCE



  ]