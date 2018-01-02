angular.module 'ahaLuminateApp'
  .directive 'companyTeamList', [
    'APP_INFO'
    (APP_INFO) ->
      templateUrl: APP_INFO.rootPath + 'dist/heart-walk/html/directive/companyTeamList.html'
      restrict: 'E'
      replace: true
      scope:
        isOpen: '='
        isChildCompany: '='
        companyName: '='
        companyId: '='
        frId: '='
        teams: '='
        hasChildren: '='
        searchCompanyTeams: '='
      controller: [
        '$scope'
        ($scope) ->
          $scope.companyTeamSearch = 
            team_name: ''
          
          $scope.toggleCompanyTeamList = ->
            $scope.isOpen = !$scope.isOpen
      ]
  ]