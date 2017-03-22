angular.module 'ahaLuminateControllers'
  .controller 'RegistrationRegCtrl', [
    '$scope'
    ($scope) ->
      $scope.submitReg = ->
        angular.element('.js--default-reg-form').submit()
        false
  ]