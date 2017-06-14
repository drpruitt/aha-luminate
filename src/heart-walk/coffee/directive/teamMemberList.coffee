angular.module 'ahaLuminateApp'
  .directive 'teamMemberList', [
    'APP_INFO'
    (APP_INFO) ->
      templateUrl: APP_INFO.rootPath + 'dist/heart-walk/html/directive/teamMemberList.html'
      restrict: 'E'
      replace: true
      scope:
        teamMembers: '='
        teamGiftsLabel: '='
        teamGiftsAmount: '='
        teamGiftsAmountFormatted: '='
        searchTeamMembers: '='
      controller: [
        '$scope'
        ($scope) ->
          $scope.teamMemberSearch = 
            member_name: ''
      ]
  ]