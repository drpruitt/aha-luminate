angular.module 'ahaLuminateControllers'
  .controller 'RegistrationWaiverCtrl', [
    '$scope'
    ($scope) ->
      $scope.submitWaiver = ->
        angular.element('.js--registration-waiver-form').submit()
        false
      
      $scope.submitWaiver()
  ]