angular.module 'ahaLuminateControllers'
  .controller 'SchoolSearchCtrl', [
    '$scope'
    'SchoolSearchService'
    ($scope, SchoolSearchService) ->
      SchoolSearchService.init $scope, 'YM Kids Heart Challenge'

      #ask for current location and search for closest schools
      SchoolSearchService.getLocation()
  ]
