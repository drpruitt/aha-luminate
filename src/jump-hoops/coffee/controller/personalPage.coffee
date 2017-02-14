angular.module 'ahaLuminateControllers'
  .controller 'PersonalPageCtrl', [
    '$scope'
    '$location'
    ($scope, $location) ->
      $scope.participantId = $location.absUrl().split('px=')[1].split('&')[0]
  ]