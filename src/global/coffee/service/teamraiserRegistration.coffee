angular.module 'ahaLuminateApp'
  .factory 'TeamraiserRegistrationService', [
    'LuminateRESTService'
    (LuminateRESTService) ->
      getParticipationTypes: (callback) ->
        dataString = 'method=getRegistrationDocument'
        LuminateRESTService.luminateExtendTeamraiserRequest dataString, false, true, callback
      
      getRegistrationDocument: (requestData, callback) ->
        dataString = 'method=getRegistrationDocument'
        dataString += '&' + requestData if requestData and requestData isnt ''
        LuminateRESTService.luminateExtendTeamraiserRequest dataString, false, true, callback
  ]