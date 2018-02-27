angular.module 'ahaLuminateControllers'
  .controller 'DonationCtrl', [
    '$scope'
    'DonationFormService'
    (DonationFormService, $scope) ->
      DonationFormService.init $scope, 'Jump Hoops'
  ]