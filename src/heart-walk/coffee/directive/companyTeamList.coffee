angular.module 'ahaLuminateApp'
  .directive 'companyTeamList', ->
    templateUrl: '../[[?xx::x[[S80:dev_branch]]x::::[[S80:dev_branch]]/]]aha-luminate/dist/heart-walk/html/directive/companyTeamList.html'
    restrict: 'E'
    replace: true
    scope:
      isOpen: '='
      isChildCompany: '='
      companyName: '='
      companyId: '='
      frId: '='
      teams: '='
      searchCompanyTeams: '='
    controller: [
      '$scope'
      ($scope) ->
        $scope.companyTeamSearch = 
          team_name: ''
        
        $scope.toggleCompanyTeamList = ->
          $scope.isOpen = !$scope.isOpen
    ]