angular.module 'trPcControllers'
  .controller 'NgPcReportsViewCtrl', [
    '$scope'
    '$location'
    ($scope, $location) ->
      $scope.location = $location.path
  ]