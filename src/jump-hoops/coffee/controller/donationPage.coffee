angular.module 'ahaLuminateControllers'
  .controller 'DonationCtrl', [
    '$scope'
    '$rootScope'
    ($scope, $rootScope) ->
      console.log 'hello donation form'

  ]