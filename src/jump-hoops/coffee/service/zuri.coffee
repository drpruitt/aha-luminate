angular.module 'ahaLuminateApp'
  .factory 'ZuriService', [
    '$rootScope'
    '$http'
    '$sce'
    ($rootScope, $http, $sce) ->
      getChallenges: (requestData, callback) ->
        url = '//hearttools.heart.org/aha_ym18/api/student/challenges/' + requestData + '?key=6Mwqh5dFV39HLDq7'
        urlSCE = $sce.trustAsResourceUrl url
        $http.jsonp(urlSCE, jsonpCallbackParam: 'callback')
          .then (response) ->
            if response.data.success is false
              callback.error response
            else
              callback.success response
          , (response) ->
            callback.failure response
      
      updateChallenge: (requestData, callback) ->
        url = '//hearttools.heart.org/aha_ym18/api/student/challenge/' + requestData + '&key=6Mwqh5dFV39HLDq7'
        urlSCE = $sce.trustAsResourceUrl url
        $http.jsonp(urlSCE, jsonpCallbackParam: 'callback')
          .then (response) ->
            callback.success response
          , (response) ->
            callback.failure response
      
      logChallenge: (requestData, callback) ->
        url = '//hearttools.heart.org/aha_ym18/api/student/' + requestData + '?key=6Mwqh5dFV39HLDq7'
        urlSCE = $sce.trustAsResourceUrl url
        $http.jsonp(urlSCE, jsonpCallbackParam: 'callback')
          .then (response) ->
            callback.success response
          , (response) ->
            callback.failure response
      
      getZooStudent: (requestData, callback) ->
        url = '//hearttools.heart.org/aha_ym18/api/student/' + requestData + '?key=6Mwqh5dFV39HLDq7'
        urlSCE = $sce.trustAsResourceUrl url
        $http.jsonp(urlSCE, jsonpCallbackParam: 'callback')
          .then (response) ->
            if response.data.success is false
              callback.error response
            else
              callback.success response
          , (response) ->
            callback.failure response
      
      getZooSchool: (requestData, callback) ->
        url = '//hearttools.heart.org/aha_ym18/api/program/school/' + requestData + '?key=6Mwqh5dFV39HLDq7'
        urlSCE = $sce.trustAsResourceUrl url
        $http.jsonp(urlSCE, jsonpCallbackParam: 'callback')
          .then (response) ->
            if response.data.success is false
              callback.error response
            else
              callback.success response
          , (response) ->
            callback.failure response
      
      getZooTeam: (requestData, callback) ->
        url = '//hearttools.heart.org/aha_ym18/api/program/team/' + requestData + '?key=6Mwqh5dFV39HLDq7'
        urlSCE = $sce.trustAsResourceUrl url
        $http.jsonp(urlSCE, jsonpCallbackParam: 'callback')
          .then (response) ->
            if response.data.success is false
              callback.error response
            else
              callback.success response
          , (response) ->
            callback.failure response
      
      getZooProgram: (callback) ->
        url = '//hearttools.heart.org/aha_ym18/api/program?key=6Mwqh5dFV39HLDq7'
        urlSCE = $sce.trustAsResourceUrl url
        $http.jsonp(urlSCE, jsonpCallbackParam: 'callback')
          .then (response) ->
            if response.data.success is false
              callback.error response
            else
              callback.success response
          , (response) ->
            callback.failure response
      
      getZooTest: (callback) ->
        url = '//hearttools.heart.org/aha_ym18/api/program/event/1163033?key=6Mwqh5dFV39HLDq7'
        urlSCE = $sce.trustAsResourceUrl url
        $http.jsonp(urlSCE, jsonpCallbackParam: 'callback')
          .then (response) ->
            if response.data.success is false
              callback.error response
            else
              callback.success response
          , (response) ->
            callback.failure response
      
      eCardTracking: (requestData) ->
        url = '//hearttools.heart.org/aha_ym18/visitlink_record.php?ecard_linktrack=' + requestData
        urlSCE = $sce.trustAsResourceUrl url
        $http
          method: 'POST'
          url: urlSCE
  ]