angular.module 'ahaLuminateApp'
  .directive 'companyParticipantList', [
    'APP_INFO'
    (APP_INFO) ->
      templateUrl: APP_INFO.rootPath + 'dist/district-heart/html/directive/companyParticipantList.html'
      restrict: 'E'
      replace: true
      scope:
        companyId: '='
        frId: '='
        participants: '='
        firstNameFilter: '='
        lastNameFilter: '='
        pageNumber: '='
      controller: [
        '$scope'
        '$filter'
        ($scope, $filter) ->
          $scope.participantList =
            sortColumn: 'amountRaised'
            sortAscending: false
          $scope.orderParticipants = (sortColumn) ->
            $scope.participantList.sortAscending = !$scope.participantList.sortAscending
            if $scope.participantList.sortColumn isnt sortColumn
              $scope.participantList.sortAscending = false
            $scope.participantList.sortColumn = sortColumn
            $scope.participants = $filter('orderBy') $scope.participants, sortColumn, !$scope.participantList.sortAscending
      ]
  ]
