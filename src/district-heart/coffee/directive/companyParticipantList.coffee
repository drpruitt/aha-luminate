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
          setParticipants = ->
            participants = $scope.participants
            firstNameFilter = $scope.firstNameFilter
            lastNameFilter = $scope.lastNameFilter
            pageNumber = $scope.pageNumber
            pageSize = 4
            participants = $filter('filter')(participants, {
              firstName: firstNameFilter
              lastName: lastNameFilter
            })
            participants = $filter('limitTo') participants, pageSize, (pageNumber * pageSize)
            $scope.participantList.participants = participants
          setParticipants()
          $scope.$watchGroup ['participants', 'firstNameFilter', 'lastNameFilter', 'pageNumber'], ->
            setParticipants()
          $scope.orderParticipants = (sortColumn) ->
            $scope.participantList.sortAscending = !$scope.participantList.sortAscending
            if $scope.participantList.sortColumn isnt sortColumn
              $scope.participantList.sortAscending = false
            $scope.participantList.sortColumn = sortColumn
            if sortColumn isnt 'fullName'
              sortColumnExpression = [
                sortColumn
                'fullName'
              ]
            $scope.participantList.participants = $filter('orderBy') $scope.participantList.participants, sortColumnExpression, !$scope.participantList.sortAscending
      ]
  ]