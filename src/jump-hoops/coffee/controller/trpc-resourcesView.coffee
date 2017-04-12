angular.module 'trPcControllers'
  .controller 'NgPcResourcesViewCtrl', [
    '$scope'
    '$location'
    ($scope, $location) ->
      $scope.location = $location.path
  ]