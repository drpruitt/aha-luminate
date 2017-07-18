angular.module 'ahaLuminateApp'
  .factory 'ZuriService', [
    '$rootScope'
    '$http'
    '$sce'
    ($rootScope, $http, $sce) ->
      getChallenges: (requestData, callback) ->
        if luminateExtend.global.tablePrefix is 'heartdev'
          url = '//hearttools.heart.org/aha_ym18_dev/api/student/challenges/' + requestData + '?key=6Mwqh5dFV39HLDq7'
        else
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
        if luminateExtend.global.tablePrefix is 'heartdev'
          url = '//hearttools.heart.org/aha_ym18_dev/api/student/challenges/' + requestData + '?key=6Mwqh5dFV39HLDq7'
        else
          url = '//hearttools.heart.org/aha_ym18/api/student/challenges/' + requestData + '?key=6Mwqh5dFV39HLDq7'
        urlSCE = $sce.trustAsResourceUrl url
        $http.jsonp(urlSCE, jsonpCallbackParam: 'callback')
          .then (response) ->
            callback.success response
          , (response) ->
            callback.failure response
      
      logChallenge: (requestData, callback) ->
        if luminateExtend.global.tablePrefix is 'heartdev'
          url = '//hearttools.heart.org/aha_ym18_dev/api/student/challenges/' + requestData + '?key=6Mwqh5dFV39HLDq7'
        else
          url = '//hearttools.heart.org/aha_ym18/api/student/challenges/' + requestData + '?key=6Mwqh5dFV39HLDq7'
        urlSCE = $sce.trustAsResourceUrl url
        $http.jsonp(urlSCE, jsonpCallbackParam: 'callback')
          .then (response) ->
            callback.success response
          , (response) ->
            callback.failure response
      
      getStudent: (requestData, callback) ->
        if luminateExtend.global.tablePrefix is 'heartdev'
          url = '//hearttools.heart.org/aha_ym18_dev/api/student/challenges/' + requestData + '?key=6Mwqh5dFV39HLDq7'
        else
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
      
      getSchool: (requestData, callback) ->
        if luminateExtend.global.tablePrefix is 'heartdev'
          url = '//hearttools.heart.org/aha_ym18_dev/api/student/challenges/' + requestData + '?key=6Mwqh5dFV39HLDq7'
        else
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
      
      getTeam: (requestData, callback) ->
        if luminateExtend.global.tablePrefix is 'heartdev'
          url = '//hearttools.heart.org/aha_ym18_dev/api/student/challenges/' + requestData + '?key=6Mwqh5dFV39HLDq7'
        else
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
      
      getProgram: (callback) ->
        if luminateExtend.global.tablePrefix is 'heartdev'
          url = '//hearttools.heart.org/aha_ym18_dev/api/student/challenges/' + requestData + '?key=6Mwqh5dFV39HLDq7'
        else
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
      
      eCardTracking: (requestData) ->
        if luminateExtend.global.tablePrefix is 'heartdev'
          url = '//hearttools.heart.org/aha_ym18_dev/api/student/challenges/' + requestData + '?key=6Mwqh5dFV39HLDq7'
        else
          url = '//hearttools.heart.org/aha_ym18/api/student/challenges/' + requestData + '?key=6Mwqh5dFV39HLDq7'
        urlSCE = $sce.trustAsResourceUrl url
        $http
          method: 'POST'
          url: urlSCE
  ]