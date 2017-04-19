angular.module 'ahaLuminateApp'
  .factory 'TeamraiserParticipantService', [
    'LuminateRESTService'
    '$http'
    '$rootScope'
    (LuminateRESTService, $http, $rootScope) ->
      getParticipants: (requestData, callback) ->
        dataString = 'method=getParticipants'
        dataString += '&' + requestData if requestData and requestData isnt ''
        LuminateRESTService.luminateExtendTeamraiserRequest dataString, false, true, callback
      
      getRegisteredTeamraisers: (requestData, callback) ->
        dataString = 'method=getRegisteredTeamraisers'
        dataString += '&' + requestData if requestData and requestData isnt ''
        LuminateRESTService.luminateExtendTeamraiserRequest dataString, false, true, callback
      
      getRegisteredTeamraisersCMS: (requestData) ->
        $http 
          method: 'GET'
          url: 'http://heart.pub30.convio.net/system/proxy.jsp?__proxyURL=https://www2.heart.org/site/CRTeamraiserAPI?method=getRegisteredTeamraisers&api_key=wDB09SQODRpVIOvX&v=1.0&response_format=json'+ requestData
        .then (response) ->
          return response
  ]