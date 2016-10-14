angular.module 'ahaLuminateApp'
  .directive 'companyParticipantList', ->
    templateUrl: '../aha-luminate/dist/heart-walk/html/directive/companyParticipantList.html'
    restrict: 'E'
    replace: true
    scope:
      isOpen: '='
      isChildCompany: '='
      companyName: '='
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