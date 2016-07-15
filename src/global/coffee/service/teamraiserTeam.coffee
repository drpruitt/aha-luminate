angular.module 'ahaLuminateApp'
  .factory 'TeamraiserTeamService', [
    'LuminateRESTService'
    (LuminateRESTService) ->
      getTeams: (requestData) ->
        dataString = 'method=getTeamsByInfo'
        dataString += '&' + requestData if requestData and requestData isnt ''
        LuminateRESTService.teamraiserRequest dataString, false, true
          .then (response) ->
            response
  ]