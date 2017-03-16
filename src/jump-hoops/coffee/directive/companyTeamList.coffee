angular.module 'ahaLuminateApp'
  .directive 'companyTeamList', ->
    templateUrl: APP_INFO.rootPath + 'dist/jump-hoops/html/directive/companyTeamList.html'
    restrict: 'E'
    replace: true
    scope:
      companyName: '='
      companyId: '='
      frId: '='
      teams: '='
