angular.module 'ahaLuminateApp'
  .directive 'teamParticipantList', [
    'APP_INFO'
    (APP_INFO) ->
      templateUrl: APP_INFO.rootPath + 'dist/middle-school/html/directive/teamParticipantList.html'
      restrict: 'E'
      replace: true
      scope:
        teamName: '='
        teamId: '='
        frId: '='
        participants: '='

  ]