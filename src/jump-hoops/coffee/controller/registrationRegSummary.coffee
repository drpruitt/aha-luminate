angular.module 'ahaLuminateControllers'
  .controller 'RegistrationRegSummaryCtrl', [
    '$scope'
    ($scope) ->
      $scope.submitRegSummary = ->
        angular.element('.js--default-regsummary-form').submit()
        false
  ]