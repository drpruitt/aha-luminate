angular.module 'ahaLuminateApp'
  .directive 'companyTeamList', ->
    templateUrl: '../aha-luminate/dist/heart-walk/html/directive/companyTeamList.html'
    restrict: 'E'
    replace: true
    scope:
      isOpen: '='
      isChildCompany: '='
      companyName: '='
      teams: '='
    controller: [
      '$scope'
      ($scope) ->
        $scope.toggleCompanyTeamList = ->
          $scope.isOpen = !$scope.isOpen
    ]