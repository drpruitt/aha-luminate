angular.module 'ahaLuminateControllers'
  .controller 'CmsCtrl', [
    '$scope'
    '$location'
    ($scope, $location) ->
      console.log 'cms ctrl'
  ]