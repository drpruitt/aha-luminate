angular.module 'ahaLuminateApp'
  .directive 'teamParticipantList', [
    'APP_INFO'
    (APP_INFO) ->
      templateUrl: APP_INFO.rootPath + 'dist/district-heart/html/directive/teamParticipantList.html'
      restrict: 'E'
      replace: true
      scope:
        teamId: '='
        frId: '='
        participants: '='

  ]