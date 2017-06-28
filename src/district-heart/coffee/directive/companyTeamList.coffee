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
        teamNameFilter: '='
        pageNumber: '='
      controller: [
        '$scope'
        '$filter'
        ($scope, $filter) ->
          $scope.teamList =
            sortColumn: 'amountRaised'
            sortAscending: false
          setTeams = ->
            teams = $scope.teams
            teamNameFilter = $scope.teamNameFilter
            pageNumber = $scope.pageNumber
            pageSize = 4
            teams = $filter('filter')(teams, {
              name: teamNameFilter
            })
            teams = $filter('limitTo') teams, pageSize, (pageNumber * pageSize)
            $scope.teamList.teams = teams
          setTeams()
          $scope.$watchGroup ['teams', 'teamNameFilter', 'pageNumber'], ->
            setTeams()
          $scope.orderTeams = (sortColumn) ->
            $scope.teamList.sortAscending = !$scope.teamList.sortAscending
            if $scope.teamList.sortColumn isnt sortColumn
              $scope.teamList.sortAscending = false
            $scope.teamList.sortColumn = sortColumn
            $scope.teamList.teams = $filter('orderBy') $scope.teamList.teams, sortColumn, !$scope.teamList.sortAscending
      ]
  ]
