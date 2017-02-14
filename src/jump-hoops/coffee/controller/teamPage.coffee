angular.module 'ahaLuminateControllers'
  .controller 'TeamPageCtrl', [
    '$scope'
    '$location'
    ($scope, $location) ->
      $scope.teamId = $location.absUrl().split('team_id=')[1].split('&')[0]
  ]