angular.module 'trPcApp'
  .directive 'teamLeaderboard', [
    'APP_INFO'
    (APP_INFO) ->
      templateUrl: APP_INFO.rootPath + 'dist/heart-walk/html/participant-center/directive/teamLeaderboard.html'
      restrict: 'E'
      replace: true
      scope:
        teams: '='
      controller: [
        '$rootScope'
        '$scope'
        ($rootScope, $scope) ->
          $scope.participantRegistration = $rootScope.participantRegistration
          
          $rootScope.$watch 'participantRegistration', ->
            $scope.participantRegistration = $rootScope.participantRegistration
      ]
  ]