angular.module 'ahaLuminateControllers'
  .controller 'TeamPageCtrl', [
    '$scope'
    '$location'
    'TeamraiserParticipantService'
    ($scope, $location, TeamraiserParticipantService) ->
      $scope.teamId = $location.absUrl().split('team_id=')[1].split('&')[0]
      
      TeamraiserParticipantService.getParticipants 'first_name=' + encodeURIComponent('%%%') + '&list_filter_column=reg.team_id&list_filter_text=' + $scope.teamId, 
      error: () ->
        $scope.teamMembers = []
      success: (response) ->
        teamMembers = response.getParticipantsResponse?.participant
        if not teamMembers
          $scope.teamMembers = []
        else
          teamMembers = [teamMembers] if not angular.isArray teamMembers
          $scope.teamMembers = teamMembers
  ]