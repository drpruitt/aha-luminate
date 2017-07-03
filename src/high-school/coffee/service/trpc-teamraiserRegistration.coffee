angular.module 'trPcApp'
  .factory 'NgPcTeamraiserRegistrationService', [
    '$rootScope'
    '$filter'
    'NgPcLuminateRESTService'
    ($rootScope, $filter, NgPcLuminateRESTService) ->
      getRegistration: ->
        NgPcLuminateRESTService.teamraiserRequest 'method=getRegistration', true, true
          .then (response) ->
            participantRegistration = response.data.getRegistrationResponse?.registration
            if not participantRegistration
              $rootScope.participantRegistration = -1
            else
              participantRegistration.goalFormatted = if participantRegistration.goal then $filter('currency')(participantRegistration.goal / 100, '$').replace('.00', '') else '$0'
              $rootScope.participantRegistration = participantRegistration
              if not participantRegistration.companyInformation?.companyId
                $rootScope.companyInfo = -1
            response
      
      updateRegistration: (requestData) ->
        dataString = 'method=updateRegistration'
        dataString += '&' + requestData if requestData and requestData isnt ''
        NgPcLuminateRESTService.teamraiserRequest dataString, true, true
          .then (response) ->
            response
      
      getParticipationType: (requestData) ->
        dataString = 'method=getParticipationType'
        dataString += '&' + requestData if requestData and requestData isnt ''
        NgPcLuminateRESTService.teamraiserRequest dataString, false, true
          .then (response) ->
            response
  ]