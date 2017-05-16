angular.module 'trPcControllers'
  .controller 'NgPcMainCtrl', [
    '$rootScope'
    '$scope'
    '$location'
    'APP_INFO'
    ($rootScope, $scope, $location, APP_INFO) ->
      $rootScope.$location = $location
      $rootScope.baseUrl = $location.absUrl().split('#')[0]
      
      $scope.location = $location.path()
      $rootScope.$on '$routeChangeSuccess', ->
        $scope.location = $location.path()
        return
  ]