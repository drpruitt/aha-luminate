angular.module 'ahaLuminateApp'
  .directive 'topTeamList', ->
    templateUrl: '../[[?xx::x[[S80:dev_branch]]x::::[[S80:dev_branch]]/]]aha-luminate/dist/heart-walk/html/directive/topTeamList.html'
    restrict: 'E'
    replace: true
    scope:
      teams: '='
      maxSize: '='