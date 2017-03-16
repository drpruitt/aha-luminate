angular.module 'ahaLuminateApp'
  .directive 'companyParticipantList', ->
    templateUrl: '../[[?xx::x[[S80:dev_branch]]x::::[[S80:dev_branch]]/]]aha-luminate/dist/heart-walk/html/directive/companyParticipantList.html'
    restrict: 'E'
    replace: true
    scope:
      isOpen: '='
      isChildCompany: '='
      companyName: '='
      companyId: '='
      frId: '='
      participants: '='
      searchCompanyParticipants: '='
    controller: [
      '$scope'
      ($scope) ->
        $scope.companyParticipantSearch = 
          participant_name: ''
        
        $scope.toggleCompanyParticipantList = ->
          $scope.isOpen = !$scope.isOpen
    ]