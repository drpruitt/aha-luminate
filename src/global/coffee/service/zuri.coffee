angular.module 'ahaLuminateApp'
  .factory 'ZuriService', [
    '$rootScope'
    '$http'
    '$sce'
    ($rootScope, $http, $sce) ->
      getZooStudent: (requestData, callback) ->
        url = 'http://hearttools.heart.org/zoocrew-api/student/1/1?key=6Mwqh5dFV39HLDq7'
        urlSCE = $sce.trustAsResourceUrl(url)
        $http.jsonp(urlSCE, jsonpCallbackParam: 'callback').then (response) ->
          if response.data.success == false
            callback.error(response)
          else
            callback.success(response)

      getZooSchool: (callback) ->
        url = 'http://hearttools.heart.org/zoocrew-api/program/1?key=6Mwqh5dFV39HLDq7'
        urlSCE = $sce.trustAsResourceUrl(url)
        $http.jsonp(urlSCE, jsonpCallbackParam: 'callback').then (response) ->
          if response.data.success == false
            callback.error(response)
          else
            callback.success(response)
  ]