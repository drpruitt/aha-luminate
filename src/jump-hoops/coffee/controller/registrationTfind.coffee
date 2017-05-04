angular.module 'ahaLuminateControllers'
  .controller 'RegistrationTfindCtrl', [
    '$scope'
    'TeamraiserTeamService'
    ($scope, TeamraiserTeamService) ->
      if not $scope.teamSearch
        $scope.teamSearch = {}
      
      $scope.teamList = {}
      getTeams = ->
        setTeams = (teams = []) ->
          if teams.length is 1
            window.location = luminateExtend.global.path.secure + 'TRR?fr_id=' + teams[0].EventId + '&pg=tfind&fr_tm_opt=existing&fr_tjoin=' + teams[0].id + '&skip_login_page=true'
          else
            $scope.teamList.teams = teams
            if not $scope.$$phase
              $scope.$apply()
        TeamraiserTeamService.getTeams 'team_company_id=' + $scope.teamSearch.companyId + '&list_page_size=500',
          error: ->
            setTeams()
          success: (response) ->
            teams = response.getTeamSearchByInfoResponse.team
            if not teams
              setTeams()
            else
              teams = [teams] if not angular.isArray teams
              setTeams teams
      if $scope.teamSearch.companyId and $scope.teamSearch.companyId isnt ''
        getTeams()
      $scope.$watch 'teamSearch.companyId', (newValue) ->
        if newValue and newValue isnt ''
          getTeams()
      
      $scope.submitTfindSearch = ->
        $scope.teamSearch.teamName = $scope.ng_team_name
  ]