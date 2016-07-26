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
      teamGiftsAmount = $teamGiftsRow.find('.team-roster-participant-raised').text()
      if teamGiftsAmount is ''
        teamGiftsAmount = '0'
      $scope.teamMembers.teamGiftsAmount = teamGiftsAmount.replace('$', '').replace(/,/g, '') * 100
      
      setTeamMembers = (teamMembers) ->
        $scope.teamMembers.members = teamMembers or []
        if not $scope.$$phase
          $scope.$apply()
      setTotalTeamMembers = (totalTeamMembers) ->
        $scope.teamMembers.totalNumber = totalTeamMembers or 0
        if not $scope.$$phase
          $scope.$apply()
      
      $scope.getTeamMembers = ->
        # TODO: scroll to top of list
        pageNumber = $scope.teamMembers.page - 1
        TeamraiserParticipantService.getParticipants 'first_name=' + encodeURIComponent('%%%') + '&list_filter_column=reg.team_id&list_filter_text=' + $scope.teamId + '&list_sort_column=total&list_ascending=false&list_page_size=4&list_page_offset=' + pageNumber, 
          error: () ->
            setTeamMembers()
            setTotalTeamMembers()
          success: (response) ->
            teamParticipants = response.getParticipantsResponse?.participant
            if not teamParticipants
              setTeamMembers()
              setTotalTeamMembers()
            else
              setTeamMembers()
              teamParticipants = [teamParticipants] if not angular.isArray teamParticipants
              teamMembers = []
              angular.forEach teamParticipants, (teamParticipant) ->
                if teamParticipant.name?.first
                  donationUrl = teamParticipant.donationUrl
                  if donationUrl
                    teamParticipant.donationUrl = donationUrl.split('/site/')[1]
                  teamMembers.push teamParticipant
              setTeamMembers teamMembers
              setTotalTeamMembers response.getParticipantsResponse.totalNumberResults
      $scope.getTeamMembers()
      
      # TODO: search form submit
  ]