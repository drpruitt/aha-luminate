angular.module 'ahaLuminateApp'
  .directive 'companyTeamList', [
    'APP_INFO'
    (APP_INFO) ->
      templateUrl: APP_INFO.rootPath + 'dist/middle-school/html/directive/companyTeamList.html'
      restrict: 'E'
      replace: true
      scope:
        companyName: '='
        companyId: '='
        frId: '='
        teams: '='
  ]
