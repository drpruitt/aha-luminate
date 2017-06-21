angular.module 'trPcApp'
  .factory 'TeamraiserTeamService', [
    '$rootScope'
    'LuminateRESTService'
    ($rootScope, LuminateRESTService) ->
      getTeams: (requestData) ->
        dataString = 'method=getTeamsByInfo'
        dataString += '&' + requestData if requestData and requestData isnt ''
        LuminateRESTService.teamraiserRequest dataString, false, true
          .then (response) ->
            response
      
      getTeam: ->
        this.getTeams 'team_id=' + $rootScope.participantRegistration.teamId
      
      joinTeam: (requestData) ->
        dataString = 'method=joinTeam'
        dataString += '&' + requestData if requestData and requestData isnt ''
        LuminateRESTService.teamraiserRequest dataString, true, true
          .then (response) ->
            response
      
      leaveTeam: ->
        LuminateRESTService.teamraiserRequest 'method=leaveTeam', true, true
          .then (response) ->
            response
      
      updateTeamInformation: (requestData) ->
        dataString = 'method=updateTeamInformation'
        dataString += '&' + requestData if requestData and requestData isnt ''
        LuminateRESTService.teamraiserRequest dataString, true, true
          .then (response) ->
            response
      
      setTeamCaptains: ->
        LuminateRESTService.teamraiserRequest 'method=setTeamCaptains', true, true
          .then (response) ->
            response
      
      getTeamCaptains: ->
        LuminateRESTService.teamraiserRequest 'method=getTeamCaptains', false, true
          .then (response) ->
            response
      
      updateCaptainsMessage: (requestData) ->
        dataString = 'method=updateCaptainsMessage'
        dataString += '&' + requestData if requestData and requestData isnt ''
        LuminateRESTService.teamraiserRequest dataString, true, true
          .then (response) ->
            response
      
      getCaptainsMessage: ->
        LuminateRESTService.teamraiserRequest 'method=getCaptainsMessage', true, true
          .then (response) ->
            response
  ]