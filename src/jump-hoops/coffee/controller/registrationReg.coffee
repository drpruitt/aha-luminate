angular.module 'ahaLuminateControllers'
  .controller 'RegistrationRegCtrl', [
    '$scope'
    'TeamraiserRegistrationService'
    ($scope, TeamraiserRegistrationService) ->
      $scope.participationType = {}
      setParticipationType = (participationType) ->
        $scope.participationType = participationType
        if not $scope.$$phase
          $scope.$apply()
      TeamraiserRegistrationService.getParticipationTypes
        error: ->
          # TODO
        success: (response) ->
          participationTypes = response.getParticipationTypesResponse.participationType
          participationTypes = [participationTypes] if not angular.isArray participationTypes
          setParticipationType participationTypes[0]
      
      $scope.submitReg = ->
        angular.element('.js--default-reg-form').submit()
        false
  ]