angular.module 'trPcApp'
  .directive 'badgeList', [
    'APP_INFO'
    (APP_INFO) ->
      templateUrl: APP_INFO.rootPath + 'dist/heart-walk/html/participant-center/directive/badgeList.html'
      restrict: 'E'
      replace: true
      scope:
        badges: '='
  ]