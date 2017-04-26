angular.module 'ahaLuminateApp'
  .factory 'ParticipantBadgesService', [
    '$http'
    '$sce'
    ($http, $sce) ->            


      getBadges: (requestData) ->
        url = '//jumphoopsstaging.boundlessnetwork.com/api/badges/student/'+requestData
        urlSCE = $sce.trustAsResourceUrl url
        console.log $sce.getTrustedResourceUrl url
        ###
        $http
          method: 'GET'
          url: urlSCE
        .then (response) ->
          console.log response
        ###
        $http
          method: 'JSONP'
          url: urlSCE 
          jsonpCallbackParam: 'callback'
        .then (response) ->
          console.log response
          ###
          if response.data.success is false
            callback.error response
          else
            callback.success response
        , (response) ->
          callback.failure response###



  ]