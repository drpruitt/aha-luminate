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
        console.log 'enter service' + $rootScope.apiKey
        luminateExtend.api
          method: 'POST'
          url: 'https://secure3.convio.net/heart/site/CRTeamraiserAPI?method=getRegisteredTeamraisers&v=1.0&api_key=' + $rootScope.apiKey + '&response_format=json'
          data: requestData
          callback: callback || angular.noop
        
  ]