angular.module 'trPcApp'
  .directive 'pageHeader', [
    'APP_INFO'
    (APP_INFO) ->
      templateUrl: APP_INFO.rootPath + 'dist/heart-walk/html/participant-center/directive/pageHeader.html'
      restrict: 'E'
      replace: true
      controller: [
        '$rootScope'
        '$scope'
        ($rootScope, $scope) ->
          console.log 'test' + $rootScope.eventDate
          console.log $rootScope.eventInfo
      ]
  ]