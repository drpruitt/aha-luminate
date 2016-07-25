angular.module 'ahaLuminateControllers'
  .controller 'TeamPageCtrl', [
    '$scope'
    '$location'
    'TeamraiserParticipantService'
    ($scope, $location, TeamraiserParticipantService) ->
      $scope.teamId = $location.absUrl().split('team_id=')[1].split('&')[0]
      
      $scope.teamMembers = 
        page: 1
      
      $defaultTeamRoster = angular.element '.js--default-team-roster'
      $teamGiftsRow = $defaultTeamRoster.find('.team-roster-participant-row').last()
      $scope.teamMembers.teamGiftsLabel = $teamGiftsRow.find('.team-roster-participant-name').text()
      $scope.teamMembers.teamGiftsAmount = $teamGiftsRow.find('.team-roster-participant-raised').text()
      $defaultTeamRoster.remove()
      
      TeamraiserParticipantService.getParticipants 'first_name=' + encodeURIComponent('%%%') + '&list_filter_column=reg.team_id&list_filter_text=' + $scope.teamId + '&list_page_size=7', 
      error: () ->
        $scope.teamMembers.members = []
        $scope.teamMembers.totalNumber = 0
      success: (response) ->
        teamMembers = response.getParticipantsResponse?.participant
        if not teamMembers
          $scope.teamMembers.members = []
          $scope.teamMembers.totalNumber = 0
        else
          $scope.teamMembers.members = []
          teamMembers = [teamMembers] if not angular.isArray teamMembers
          angular.forEach teamMembers, (teamMember) ->
            if teamMember.name?.first
              $scope.teamMembers.members.push teamMember
          $scope.teamMembers.totalNumber = response.getParticipantsResponse.totalNumberResults
  ]