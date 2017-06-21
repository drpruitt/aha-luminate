angular.module 'ahaLuminateApp'
  .directive 'teamParticipantList', [
    'APP_INFO'
    (APP_INFO) ->
      templateUrl: APP_INFO.rootPath + 'dist/jump-hoops/html/directive/teamParticipantList.html'
      restrict: 'E'
      replace: true
      scope:
        teamId: '='
        frId: '='
        participants: '='

  ]