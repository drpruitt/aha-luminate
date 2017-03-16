angular.module 'ahaLuminateApp'
  .directive 'topTeamList', ->
    templateUrl: '../aha-luminate/dist/heart-walk/html/directive/topTeamList.html'
    restrict: 'E'
    replace: true
    scope:
      teams: '='
      maxSize: '='