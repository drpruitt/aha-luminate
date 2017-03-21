angular.module 'ahaLuminateControllers'
  .controller 'RegistrationPtypeCtrl', [
    '$scope'
    ($scope) ->
      $scope.submitPtype = ->
        angular.element('.js--default-ptype-form').submit()
        false
  ]