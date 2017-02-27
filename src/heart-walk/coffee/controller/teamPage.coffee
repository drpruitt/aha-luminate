angular.module 'ahaLuminateControllers'
  .controller 'TeamPageCtrl', [
    '$scope'
    '$location'
    '$timeout'
    '$filter'
    'TeamraiserTeamService'
    'TeamraiserParticipantService'
    ($scope, $location, $timeout, $filter, TeamraiserTeamService, TeamraiserParticipantService) ->
      $scope.teamId = $location.absUrl().split('team_id=')[1].split('&')[0]
      
      $scope.teamProgress = {}
      
      setTeamFundraisingProgress = (amountRaised, goal) ->
        $scope.teamProgress.amountRaised = amountRaised or 0
        $scope.teamProgress.amountRaised = Number $scope.teamProgress.amountRaised
        $scope.teamProgress.goal = goal or 0
        $scope.teamProgress.percent = 2
        $timeout ->
          percent = $scope.teamProgress.percent
          if $scope.teamProgress.goal isnt 0
            percent = Math.ceil(($scope.teamProgress.amountRaised / $scope.teamProgress.goal) * 100)
          if percent < 2
            percent = 2
          if percent > 98
            percent = 98
          $scope.teamProgress.percent = percent
          if not $scope.$$phase
            $scope.$apply()
        , 500
        if not $scope.$$phase
          $scope.$apply()
      TeamraiserTeamService.getTeams 'team_id=' + $scope.teamId, 
        error: ->
          setTeamFundraisingProgress()
        success: (response) ->
          teamInfo = response.getTeamSearchByInfoResponse?.team
          if not teamInfo
            setTeamFundraisingProgress()
          else
            setTeamFundraisingProgress teamInfo.amountRaised, teamInfo.goal
      
      $scope.teamMembers = 
        page: 1
      
      $defaultTeamRoster = angular.element '.js--default-team-roster'
      $teamGiftsRow = $defaultTeamRoster.find('.team-roster-participant-row').last()
      $scope.teamMembers.teamGiftsLabel = $teamGiftsRow.find('.team-roster-participant-name').text()
      teamGiftsAmount = $teamGiftsRow.find('.team-roster-participant-raised').text()
      if teamGiftsAmount is ''
        teamGiftsAmount = '0'
      $scope.teamMembers.teamGiftsAmount = teamGiftsAmount.replace('$', '').replace(/,/g, '') * 100
      $scope.teamMembers.teamGiftsAmount = Number $scope.teamMembers.teamGiftsAmount
      $scope.teamMembers.teamGiftsAmountFormatted = $filter('currency')($scope.teamMembers.teamGiftsAmount / 100, '$', 0)
      
      setTeamMembers = (teamMembers, totalNumber) ->
        $scope.teamMembers.members = teamMembers or []
        $scope.teamMembers.totalNumber = totalNumber or 0
        if not $scope.$$phase
          $scope.$apply()
      
      $scope.getTeamMembers = ->
        # TODO: scroll to top of list
        pageNumber = $scope.teamMembers.page - 1
        TeamraiserParticipantService.getParticipants 'first_name=' + encodeURIComponent('%%%') + '&list_filter_column=reg.team_id&list_filter_text=' + $scope.teamId + '&list_sort_column=total&list_ascending=false&list_page_size=4&list_page_offset=' + pageNumber, 
          error: () ->
            setTeamMembers()
          success: (response) ->
            setTeamMembers()
            teamParticipants = response.getParticipantsResponse?.participant
            if teamParticipants?
              teamParticipants = [teamParticipants] if not angular.isArray teamParticipants
              teamMembers = []
              angular.forEach teamParticipants, (teamParticipant) ->
                if teamParticipant.name?.first
                  teamParticipant.amountRaised = Number teamParticipant.amountRaised
                  teamParticipant.amountRaisedFormatted = $filter('currency')(teamParticipant.amountRaised / 100, '$', 0)
                  donationUrl = teamParticipant.donationUrl
                  if donationUrl?
                    teamParticipant.donationUrl = donationUrl.split('/site/')[1]
                  teamMembers.push teamParticipant
              setTeamMembers teamMembers, response.getParticipantsResponse.totalNumberResults
      $scope.getTeamMembers()
      
      # TODO: search form submit
  ]