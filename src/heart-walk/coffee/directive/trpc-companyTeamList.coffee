angular.module 'trPcApp'
  .directive 'trpcCompanyTeamList', [
    'APP_INFO'
    (APP_INFO) ->
      templateUrl: APP_INFO.rootPath + 'dist/heart-walk/html/participant-center/directive/companyTeamList.html'
      restrict: 'E'
      replace: true
      scope:
        sortColumn: '='
        sortAscending: '='
        sortTeams: '='
        teams: '='
      controller: [
        '$rootScope'
        '$scope'
        ($rootScope, $scope) ->
          $scope.participantRegistration = $rootScope.participantRegistration
          
          $rootScope.$watch 'participantRegistration', ->
            $scope.participantRegistration = $rootScope.participantRegistration
      ]
  ]