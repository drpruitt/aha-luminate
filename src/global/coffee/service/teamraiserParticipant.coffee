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
  ]