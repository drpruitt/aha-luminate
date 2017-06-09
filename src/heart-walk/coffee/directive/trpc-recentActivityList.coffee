angular.module 'trPcApp'
  .directive 'recentActivityList', [
    'APP_INFO'
    (APP_INFO) ->
      templateUrl: APP_INFO.rootPath + 'dist/heart-walk/html/participant-center/directive/recentActivityList.html'
      restrict: 'E'
      replace: true
      scope:
        records: '='
  ]