angular.module 'trPcApp'
  .directive 'contactList', [
    'APP_INFO'
    (APP_INFO) ->
      templateUrl: APP_INFO.rootPath + 'dist/heart-walk/html/participant-center/directive/contactList.html'
      restrict: 'E'
      replace: true
      scope:
        contacts: '='
        toggleContact: '='
        selectContact: '='
        deleteContact: '='
  ]