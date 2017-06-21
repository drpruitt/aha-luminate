angular.module 'trPcApp'
  .directive 'newsFeedList', [
    'APP_INFO'
    (APP_INFO) ->
      templateUrl: APP_INFO.rootPath + 'dist/heart-walk/html/participant-center/directive/newsFeedList.html'
      restrict: 'E'
      replace: true
      scope:
        items: '='
  ]