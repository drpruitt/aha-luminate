angular.module 'ahaLuminateApp'
  .directive 'topParticipantList', [  
    'APP_INFO'
    (APP_INFO) ->
      templateUrl: APP_INFO.rootPath + 'dist/heart-walk/html/directive/topParticipantList.html'
      restrict: 'E'
      replace: true
      scope:
        participants: '='
        maxSize: '='
  ]