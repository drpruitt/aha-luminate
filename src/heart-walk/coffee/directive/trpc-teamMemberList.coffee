angular.module 'trPcApp'
  .directive 'trpcTeamMemberList', [
    'APP_INFO'
    (APP_INFO) ->
      templateUrl: APP_INFO.rootPath + 'dist/heart-walk/html/participant-center/directive/teamMemberList.html'
      restrict: 'E'
      replace: true
      scope:
        members: '='
        sortColumn: '='
        sortAscending: '='
        sortMembers: '='
        emailTeamMember: '='
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