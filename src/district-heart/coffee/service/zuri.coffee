angular.module 'ahaLuminateApp'
  .factory 'ZuriService', [
    '$rootScope'
    '$http'
    '$sce'
    ($rootScope, $http, $sce) ->
      getMinutes: (requestData, callback) ->
        if $rootScope.tablePrefix is 'heartdev'
          url = '//hearttools.heart.org/dhc18_dev/participant/minutes/' + requestData + '?key=N24DEcjHQkez6NAf'
        else
          url = '//hearttools.heart.org/dhc18/participant/minutes/' + requestData + '?key=N24DEcjHQkez6NAf'
        $http.jsonp($sce.trustAsResourceUrl(url), jsonpCallbackParam: 'callback')
          .then (response) ->
            if response.data.success is false
              callback.error response
            else
              callback.success response
          , (response) ->
            callback.failure response
      
      logMinutes: (requestData, callback) ->
        if $rootScope.tablePrefix is 'heartdev'
          url = '//hearttools.heart.org/dhc18_dev/participant/update/' + requestData + '&key=N24DEcjHQkez6NAf'
        else
          url = '//hearttools.heart.org/dhc18/participant/update/' + requestData + '&key=N24DEcjHQkez6NAf'
        $http.jsonp($sce.trustAsResourceUrl(url), jsonpCallbackParam: 'callback')
          .then (response) ->
            callback.success response
          , (response) ->
            callback.failure response
      
      getDistrictTeams: (requestData, callback) ->
        if $rootScope.tablePrefix is 'heartdev'
          url = '//hearttools.heart.org/dhc18_dev/group/company/' + requestData + '?key=N24DEcjHQkez6NAf'
        else
          url = '//hearttools.heart.org/dhc18/group/company/' + requestData + '?key=N24DEcjHQkez6NAf'
        $http.jsonp($sce.trustAsResourceUrl(url), jsonpCallbackParam: 'callback')
          .then (response) ->
            if response.data.success is false
              callback.error response
            else
              callback.success response
          , (response) ->
            callback.failure response
      
      getDistrictParticipants: (requestData, callback) ->
        if $rootScope.tablePrefix is 'heartdev'
          url = '//hearttools.heart.org/dhc18_dev/group/company/' + requestData + '?group_by=constituent&key=N24DEcjHQkez6NAf'
        else
          url = '//hearttools.heart.org/dhc18/group/company/' + requestData + '?group_by=constituent&key=N24DEcjHQkez6NAf'
        $http.jsonp($sce.trustAsResourceUrl(url), jsonpCallbackParam: 'callback')
          .then (response) ->
            if response.data.success is false
              callback.error response
            else
              callback.success response
          , (response) ->
            callback.failure response
      
      getTeamParticipants: (requestData, callback) ->
        if $rootScope.tablePrefix is 'heartdev'
          url = '//hearttools.heart.org/dhc18_dev/group/team/' + requestData + '?group_by=constituent&key=N24DEcjHQkez6NAf'
        else
          url = '//hearttools.heart.org/dhc18/group/team/' + requestData + '?group_by=constituent&key=N24DEcjHQkez6NAf'
        $http.jsonp($sce.trustAsResourceUrl(url), jsonpCallbackParam: 'callback')
          .then (response) ->
            if response.data.success is false
              callback.error response
            else
              callback.success response
          , (response) ->
            callback.failure response
      
      getProgram: (callback) ->
        if $rootScope.tablePrefix is 'heartdev'
          url = '//hearttools.heart.org/dhc18_dev/group/?key=N24DEcjHQkez6NAf'
        else
          url = '//hearttools.heart.org/dhc18/group/?key=N24DEcjHQkez6NAf'
        $http.jsonp($sce.trustAsResourceUrl(url), jsonpCallbackParam: 'callback')
          .then (response) ->
            if response.data.success is false
              callback.error response
            else
              callback.success response
          , (response) ->
            callback.failure response
  ]