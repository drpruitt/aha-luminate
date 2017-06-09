angular.module 'trPcApp'
  .directive 'teamsList', [
    'APP_INFO'
    (APP_INFO) ->
      templateUrl: APP_INFO.rootPath + 'dist/heart-walk/html/participant-center/directive/teamsList.html'
      restrict: 'E'
      transclude: true
      replace: true
      scope:
        teams: '='
        joinTeam: '&'
  ]