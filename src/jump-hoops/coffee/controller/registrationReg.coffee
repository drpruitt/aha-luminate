angular.module 'ahaLuminateControllers'
  .controller 'RegistrationRegCtrl', [
    '$scope'
    'TeamraiserRegistrationService'
    ($scope, TeamraiserRegistrationService) ->
      TeamraiserRegistrationService.getParticipationTypes
        error: ->
          # TODO
        success: (response) ->
          participationTypes = response.getParticipationTypesResponse.participationType
          participationTypes = [participationTypes] if not angular.isArray participationTypes
      
      $scope.submitReg = ->
        angular.element('.js--default-reg-form').submit()
        false
  ]