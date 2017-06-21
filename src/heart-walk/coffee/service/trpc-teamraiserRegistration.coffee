angular.module 'trPcApp'
  .factory 'TeamraiserRegistrationService', [
    '$rootScope'
    '$filter'
    'LuminateRESTService'
    ($rootScope, $filter, LuminateRESTService) ->
      getRegistration: ->
        LuminateRESTService.teamraiserRequest 'method=getRegistration', true, true
          .then (response) ->
            participantRegistration = response.data.getRegistrationResponse?.registration
            if not participantRegistration
              $rootScope.participantRegistration = -1
            else
              participantRegistration.goalFormatted = if participantRegistration.goal then $filter('currency')(participantRegistration.goal / 100, '$').replace('.00', '') else '$0'
              $rootScope.participantRegistration = participantRegistration
            response
      
      updateRegistration: (requestData) ->
        dataString = 'method=updateRegistration'
        dataString += '&' + requestData if requestData and requestData isnt ''
        LuminateRESTService.teamraiserRequest dataString, true, true
          .then (response) ->
            response
      
      getParticipationType: (requestData) ->
        dataString = 'method=getParticipationType'
        dataString += '&' + requestData if requestData and requestData isnt ''
        LuminateRESTService.teamraiserRequest dataString, false, true
          .then (response) ->
            response
  ]