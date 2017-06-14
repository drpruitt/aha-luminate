angular.module 'ahaLuminateApp'
  .directive 'companyParticipantList', [
    'APP_INFO'
    (APP_INFO) ->
      templateUrl: APP_INFO.rootPath + 'dist/heart-walk/html/directive/companyParticipantList.html'
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
  ]