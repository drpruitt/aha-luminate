angular.module 'ahaLuminateApp'
  .directive 'topTeamList', [
    'APP_INFO'
    (APP_INFO) ->
      templateUrl: APP_INFO.rootPath + 'dist/heart-walk/html/directive/topTeamList.html'
      restrict: 'E'
      replace: true
      scope:
        teams: '='
        maxSize: '='
  ]