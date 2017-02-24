angular.module 'ahaLuminateApp'
  .directive 'companyTeamList', ->
    templateUrl: '../aha-luminate/dist/jump-hoops/html/directive/companyTeamList.html'
    restrict: 'E'
    replace: true
    scope:
      companyName: '='
      companyId: '='
      frId: '='
      teams: '='
    controller: [
      '$scope'
      ($scope) ->
        $scope.companyTeamSearch = 
          team_name: ''
        
        $scope.toggleCompanyTeamList = ->
          $scope.isOpen = !$scope.isOpen
    ]