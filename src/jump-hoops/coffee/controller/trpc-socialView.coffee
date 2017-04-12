angular.module 'trPcControllers'
  .controller 'NgPcSocialViewCtrl', [
    '$scope'
    '$location'
    ($scope, $location) ->
      $scope.location = $location.path
  ]