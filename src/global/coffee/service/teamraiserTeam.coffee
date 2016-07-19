angular.module 'ahaLuminateApp'
  .factory 'TeamraiserTeamService', [
    'LuminateRESTService'
    (LuminateRESTService) ->
      getTeams: (requestData, callback) ->
        dataString = 'method=getTeamsByInfo'
        dataString += '&' + requestData if requestData and requestData isnt ''
        LuminateRESTService.luminateExtendTeamraiserRequest dataString, false, true, callback
  ]