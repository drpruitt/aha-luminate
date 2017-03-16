angular.module 'ahaLuminateApp'
  .directive 'companyParticipantList', ->
    templateUrl: '../[[?xx::x[[S80:dev_branch]]x::::[[S80:dev_branch]]/]]aha-luminate/dist/jump-hoops/html/directive/companyParticipantList.html'
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