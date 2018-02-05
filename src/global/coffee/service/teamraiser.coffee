angular.module 'ahaLuminateApp'
  .factory 'TeamraiserService', [
    'LuminateRESTService'
    '$http'
    '$rootScope'
    (LuminateRESTService, $http, $rootScope) ->
      getTeamRaisersByInfo: (requestData, callback) ->
        dataString = 'method=getTeamraisersByInfo'
        dataString += '&' + requestData if requestData and requestData isnt ''
        LuminateRESTService.luminateExtendTeamraiserRequest dataString, false, true, callback
  ]