angular.module 'ahaLuminateControllers'
  .controller 'SchoolSearchCtrl', [
    '$scope'
    'SchoolSearchService'
    ($scope, SchoolSearchService) ->
      SchoolSearchService.init $scope, 'YM Kids Heart Challenge'
  ]
