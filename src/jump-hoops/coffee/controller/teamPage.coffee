angular.module 'ahaLuminateControllers'
  .controller 'TeamPageCtrl', [
    '$scope'
    '$rootScope'
    '$location'
    '$filter'
    '$timeout'
    'TeamraiserTeamService'
    'TeamraiserParticipantService'
    'ZuriService'
    ($scope, $rootScope, $location, $filter, $timeout, TeamraiserTeamService, TeamraiserParticipantService, ZuriService) ->
      $scope.teamId = $location.absUrl().split('team_id=')[1].split('&')[0]
      $scope.teamProgress = []
      $rootScope.teamName = ''
      $scope.eventDate = ''
      $scope.totalParticipants = ''
      $scope.teamId = ''
      $scope.studentsPledgedTotal = ''
      $scope.activity1amt = ''
      $scope.activity2amt = ''
      $scope.activity3amt = ''


      setTeamFundraisingProgress = (amountRaised, goal) ->
        $scope.teamProgress.amountRaised = amountRaised
        $scope.teamProgress.amountRaised = Number $scope.teamProgress.amountRaised
        $scope.teamProgress.amountRaisedFormatted = $filter('currency')($scope.teamProgress.amountRaised / 100, '$').replace '.00', ''
        $scope.teamProgress.goal = goal or 0
        $scope.teamProgress.goal = Number $scope.teamProgress.goal
        $scope.teamProgress.goalFormatted = $filter('currency')($scope.teamProgress.goal / 100, '$').replace '.00', ''
        $scope.teamProgress.percent = 2
        $timeout ->
          percent = $scope.teamProgress.percent
          if $scope.teamProgress.goal isnt 0
            percent = Math.ceil(($scope.teamProgress.amountRaised / $scope.teamProgress.goal) * 100)
          if percent < 2
            percent = 2
          if percent > 100
            percent = 100
          $scope.companyProgress.percent = percent
          if not $scope.$$phase
            $scope.$apply()
        , 500
        if not $scope.$$phase
          $scope.$apply()

      getTeamTotals = ->
        TeamraiserTeamService.getTeams 'team_id=' + $scope.teamId, 
            success: (response) ->
              console.log response
              ###
              $scope.participantCount = response.getCompaniesResponse.company.participantCount 
              $scope.totalTeams = response.getCompaniesResponse.company.teamCount
              eventId = response.getCompaniesResponse.company.eventId
              amountRaised = response.getCompaniesResponse.company.amountRaised
              goal = response.getCompaniesResponse.company.goal
              name = response.getCompaniesResponse.company.companyName
              coordinatorId = response.getCompaniesResponse.company.coordinatorId
              $rootScope.companyName = name
              setCompanyFundraisingProgress amountRaised, goal

              TeamraiserCompanyService.getCoordinatorQuestion coordinatorId, eventId
                .then (response) ->
                  $scope.eventDate = response.data.coordinator.event_date

                  if $scope.totalTeams = 1
                    $scope.teamId = response.data.coordinator.team_id
            ###

      getCompanyTotals()



  ]