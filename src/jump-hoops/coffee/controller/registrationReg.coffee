angular.module 'ahaLuminateControllers'
  .controller 'RegistrationRegCtrl', [
    '$scope'
    'TeamraiserRegistrationService'
    ($scope, TeamraiserRegistrationService) ->
      $scope.submitReg = ->
        angular.element('.js--default-reg-form').submit()
        false
  ]