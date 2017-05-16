angular.module 'trPcApp'
  .directive 'pcEmailMessageList', ->
    templateUrl: '../angular-teamraiser-participant-center/dist/html/directive/emailMessageList.html'
    restrict: 'E'
    replace: true
    scope:
      messages: '='
      selectMessage: '='
      deleteMessage: '='