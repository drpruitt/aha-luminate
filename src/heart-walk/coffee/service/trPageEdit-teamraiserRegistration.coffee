angular.module 'trPageEditApp'
  .factory 'TeamraiserRegistrationService', [
    'NgPageEditLuminateRESTService'
    (NgPageEditLuminateRESTService) ->
      getRegistration: (callback) ->
        NgPageEditLuminateRESTService.luminateExtendTeamraiserRequest 'method=getRegistration', true, true, callback
  ]