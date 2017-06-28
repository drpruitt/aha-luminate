angular.module 'ahaLuminateApp'
  .factory 'ZuriService', [
    '$rootScope'
    '$http'
    '$sce'
    ($rootScope, $http, $sce) ->
      getMinutes: (requestData, callback) ->
        url = '//hearttools.heart.org/dhc18/participant/minutes/' + requestData + '?key=N24DEcjHQkez6NAf'
        urlSCE = $sce.trustAsResourceUrl url
        $http.jsonp(urlSCE, jsonpCallbackParam: 'callback')
          .then (response) ->
            if response.data.success is false
              callback.error response
            else
              callback.success response
          , (response) ->
            callback.failure response
       
      logMinutes: (requestData, callback) ->
        url = '//hearttools.heart.org/dhc18/participant/update/' + requestData + '&key=N24DEcjHQkez6NAf'
        urlSCE = $sce.trustAsResourceUrl url
        $http.jsonp(urlSCE, jsonpCallbackParam: 'callback')
          .then (response) ->
            callback.success response
          , (response) ->
            callback.failure response
      
      getDistrictTeams: (requestData, callback) ->
        url = '//hearttools.heart.org/dhc18/group/company/' + requestData + '?key=N24DEcjHQkez6NAf'
        urlSCE = $sce.trustAsResourceUrl url
        $http.jsonp(urlSCE, jsonpCallbackParam: 'callback')
          .then (response) ->
            if response.data.success is false
              callback.error response
            else
              callback.success response
          , (response) ->
            callback.failure response
      
      getDistrictParticipants: (requestData, callback) ->
        url = '//hearttools.heart.org/dhc18/group/company/' + requestData + '?group_by=constituent&key=N24DEcjHQkez6NAf'
        urlSCE = $sce.trustAsResourceUrl url
        $http.jsonp(urlSCE, jsonpCallbackParam: 'callback')
          .then (response) ->
            if response.data.success is false
              callback.error response
            else
              callback.success response
          , (response) ->
            callback.failure response
      
      getTeamParticipants: (requestData, callback) ->
        url = '//hearttools.heart.org/dhc18/group/team/' + requestData + '?group_by=constituent&key=N24DEcjHQkez6NAf'
        urlSCE = $sce.trustAsResourceUrl url
        $http.jsonp(urlSCE, jsonpCallbackParam: 'callback')
          .then (response) ->
            if response.data.success is false
              callback.error response
            else
              callback.success response
          , (response) ->
            callback.failure response
      
      getProgram: (callback) ->
        url = '//hearttools.heart.org/dhc18/group/?key=N24DEcjHQkez6NAf'
        urlSCE = $sce.trustAsResourceUrl url
        $http.jsonp(urlSCE, jsonpCallbackParam: 'callback')
          .then (response) ->
            if response.data.success is false
              callback.error response
            else
              callback.success response
          , (response) ->
            callback.failure response
  ]