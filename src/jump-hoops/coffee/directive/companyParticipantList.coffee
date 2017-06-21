angular.module 'ahaLuminateApp'
  .directive 'companyParticipantList', [
    'APP_INFO'
    (APP_INFO) ->
      templateUrl: APP_INFO.rootPath + 'dist/jump-hoops/html/directive/companyParticipantList.html'
      restrict: 'E'
      replace: true
      scope:
        companyId: '='
        frId: '='
        participants: '='
    ]
  ]