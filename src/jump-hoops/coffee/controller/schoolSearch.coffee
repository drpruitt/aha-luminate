angular.module 'ahaLuminateControllers'
  .controller 'SchoolSearchCtrl', [
    '$scope'
    '$rootScope'
    '$location'
    ($scope, $rootScope, $location) ->
      console.log 'hello'

  ]