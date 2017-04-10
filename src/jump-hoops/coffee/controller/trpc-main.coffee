angular.module 'trPcControllers'
  .controller 'NgPcMainCtrl', [
    '$rootScope'
    '$scope'
    '$location'
    'APP_INFO'
    ($rootScope, $scope, $location, APP_INFO) ->
      $rootScope.$location = $location
      $rootScope.baseUrl = $location.absUrl().split('#')[0]
  ]