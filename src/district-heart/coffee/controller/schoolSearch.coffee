angular.module 'ahaLuminateControllers'
  .controller 'SchoolSearchCtrl', [
    '$scope'
    '$filter'
    'SchoolSearchService'
    ($scope, $filter, SchoolSearchService) ->
      SchoolSearchService.init()
  ]