angular.module 'trPcApp'
  .directive 'trpcCompanyParticipantList', [
    'APP_INFO'
    (APP_INFO) ->
      templateUrl: APP_INFO.rootPath + 'dist/heart-walk/html/participant-center/directive/companyParticipantList.html'
      restrict: 'E'
      replace: true
      scope:
        participants: '='
        sortColumn: '='
        sortAscending: '='
        sortParticipants: '='
        emailParticipant: '='
      controller: [
        '$rootScope'
        '$scope'
        ($rootScope, $scope) ->
          $scope.participantRegistration = $rootScope.participantRegistration
          $rootScope.$watch 'participantRegistration', ->
            $scope.participantRegistration = $rootScope.participantRegistration
          
          $scope.device = $rootScope.device
          $rootScope.$watch 'device', ->
            $scope.device = $rootScope.device
      ]
  ]