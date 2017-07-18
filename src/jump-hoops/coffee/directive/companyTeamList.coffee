angular.module 'ahaLuminateApp'
  .directive 'companyTeamList', [
    'APP_INFO'
    (APP_INFO) ->
      templateUrl: APP_INFO.rootPath + 'dist/jump-hoops/html/directive/companyTeamList.html'
      restrict: 'E'
      replace: true
      scope:
        companyName: '='
        companyId: '='
        frId: '='
        teams: '='

      $scope.teamListSetting =
        sortColumn: 'amountRaised'
        sortAscending: false
        totalNumber: 0
        currentPage: 1
        paginationItemsPerPage: 3
        paginationMaxSize: 3
      $scope.teamPaginate = (value) ->
        begin = ($scope.teamListSetting.currentPage - 1) * $scope.teamListSetting.paginationItemsPerPage
        end = begin + $scope.teamListSetting.paginationItemsPerPage
        index = teams.indexOf value
        begin <= index and index < end
  ]
