angular.module 'ahaLuminateControllers'
  .controller 'TeamPageCtrl', [
    '$scope'
    '$rootScope'
    '$location'
    '$filter'
    '$timeout'
    'TeamraiserTeamService'
    'TeamraiserParticipantService'
    'TeamraiserCompanyService'
    'ZuriService'
    ($scope, $rootScope, $location, $filter, $timeout, TeamraiserTeamService, TeamraiserParticipantService, TeamraiserCompanyService, ZuriService) ->
      $scope.teamId = $location.absUrl().split('team_id=')[1].split('&')[0]
      $scope.teamProgress = []
      $rootScope.teamName = ''
      $scope.eventDate = ''
      $scope.participantCount = ''
      $scope.studentsPledgedTotal = ''
      $scope.activity1amt = ''
      $scope.activity2amt = ''
      $scope.activity3amt = ''
      
      setTeamFundraisingProgress = (amountRaised, goal) ->
        $scope.teamProgress.amountRaised = amountRaised or 0
        $scope.teamProgress.amountRaised = Number $scope.teamProgress.amountRaised
        $scope.teamProgress.amountRaisedFormatted = $filter('currency')($scope.teamProgress.amountRaised / 100, '$').replace '.00', ''
        $scope.teamProgress.goal = goal or 0
        $scope.teamProgress.goal = Number $scope.teamProgress.goal
        $scope.teamProgress.goalFormatted = $filter('currency')($scope.teamProgress.goal / 100, '$').replace '.00', ''

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

      getTeamData = ->
        TeamraiserTeamService.getTeams 'team_id=' + $scope.teamId, 
          error: ->
            setTeamFundraisingProgress()
          success: (response) ->
            teamInfo = response.getTeamSearchByInfoResponse?.team
            companyId = teamInfo.companyId
            $scope.participantCount = teamInfo.numMembers
            
            if not teamInfo
              setTeamFundraisingProgress()
            else
              setTeamFundraisingProgress teamInfo.amountRaised, teamInfo.goal

            TeamraiserCompanyService.getCompanies 'company_id=' + companyId, 
              success: (response) ->
                coordinatorId = response.getCompaniesResponse?.company.coordinatorId
                eventId = response.getCompaniesResponse?.company.eventId

                TeamraiserCompanyService.getCoordinatorQuestion coordinatorId, eventId
                  .then (response) ->
                    $scope.eventDate = response.data.coordinator.event_date

      getTeamData()



  ]