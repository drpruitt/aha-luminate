angular.module 'ahaLuminateApp'
  .directive 'companyTeamList', [
    'APP_INFO'
    (APP_INFO) ->
      templateUrl: APP_INFO.rootPath + 'dist/district-heart/html/directive/companyTeamList.html'
      restrict: 'E'
      replace: true
      scope:
        companyId: '='
        frId: '='
        teams: '='
      controller: [
        '$scope'
        '$filter'
        ($scope, $filter) ->
          $scope.teamList =
            sortColumn: 'amountRaised'
            sortAscending: false
          $scope.orderTeams = (sortColumn) ->
            $scope.teamList.sortAscending = !$scope.teamList.sortAscending
            if $scope.teamList.sortColumn isnt sortColumn
              $scope.teamList.sortAscending = false
            $scope.teamList.sortColumn = sortColumn
            $scope.teams = $filter('orderBy') $scope.teams, sortColumn, !$scope.teamList.sortAscending
      ]
  ]
