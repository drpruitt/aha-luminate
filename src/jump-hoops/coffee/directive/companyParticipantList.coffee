angular.module 'ahaLuminateApp'
  .directive 'companyParticipantList', ->
    templateUrl: '../aha-luminate/dist/jump-hoops/html/directive/companyParticipantList.html'
    restrict: 'E'
    replace: true
    scope:
      companyName: '='
      companyId: '='
      frId: '='
      participants: '='
    controller: [
      '$scope'
      ($scope) ->
        $scope.companyParticipantSearch = 
          participant_name: ''
        
        $scope.toggleCompanyParticipantList = ->
          $scope.isOpen = !$scope.isOpen
    ]