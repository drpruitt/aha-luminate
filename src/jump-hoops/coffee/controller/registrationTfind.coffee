angular.module 'ahaLuminateControllers'
  .controller 'RegistrationTfindCtrl', [
    '$scope'
    'TeamraiserTeamService'
    ($scope, TeamraiserTeamService) ->
      $scope.teamList = {}
      getTeams = ->
        setTeams = (teams) ->
          $scope.teamList.teams = teams or []
          if not $scope.$$phase
            $scope.$apply()
        TeamraiserTeamService.getTeams 'team_company_id=' + $scope.companyId + '&list_page_size=500',
          error: ->
            setTeams()
          success: (response) ->
            teams = response.getTeamSearchByInfoResponse.team
            if not teams
              setTeams()
            else
              teams = [teams] if not angular.isArray teams
              console.log teams
              setTeams teams
      if $scope.companyId and $scope.companyId isnt ''
        getTeams()
      $scope.$watch 'companyId', (newValue) ->
        if newValue and newValue isnt ''
          getTeams()
  ]