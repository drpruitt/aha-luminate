angular.module 'trPcApp'
  .directive 'emailMessageList', [
    'APP_INFO'
    (APP_INFO) ->
      templateUrl: APP_INFO.rootPath + 'dist/heart-walk/html/participant-center/directive/emailMessageList.html'
      restrict: 'E'
      replace: true
      scope:
        messages: '='
        selectMessage: '='
        deleteMessage: '='
  ]