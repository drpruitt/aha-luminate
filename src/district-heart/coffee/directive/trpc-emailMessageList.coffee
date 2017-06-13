angular.module 'trPcApp'
  .directive 'pcEmailMessageList', [
    'APP_INFO'
    (APP_INFO) ->
      templateUrl: APP_INFO.rootPath + 'dist/district-heart/html/participant-center/directive/emailMessageList.html'
      restrict: 'E'
      replace: true
      scope:
        messages: '='
        selectMessage: '='
        deleteMessage: '='
  ]