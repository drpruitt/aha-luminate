angular.module 'ahaLuminateApp'
  .directive 'companyParticipantList', [
    'APP_INFO'
    (APP_INFO) ->
    templateUrl: APP_INFO.rootPath + 'dist/jump-hoops/html/directive/companyParticipantList.html'
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
  ]