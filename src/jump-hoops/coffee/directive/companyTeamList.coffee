angular.module 'ahaLuminateApp'
  .directive 'companyTeamList', ->
    templateUrl: '../[[?xx::x[[S80:dev_branch]]x::::[[S80:dev_branch]]/]]aha-luminate/dist/jump-hoops/html/directive/companyTeamList.html'
    restrict: 'E'
    replace: true
    scope:
      companyName: '='
      companyId: '='
      frId: '='
      teams: '='
