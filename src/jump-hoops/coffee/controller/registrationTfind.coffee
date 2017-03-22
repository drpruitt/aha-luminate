angular.module 'ahaLuminateControllers'
  .controller 'RegistrationTfindCtrl', [
    '$scope'
    'TeamraiserTeamService'
    ($scope, TeamraiserTeamService) ->
      getTeams = ->
        TeamraiserTeamService.getTeams 'team_company_id=' + $scope.companyId + '&list_page_size=500',
          error: ->
            # TODO
          success: (response) ->
            teams = response.getTeamSearchByInfoResponse.team
            teams = [teams] if not angular.isArray teams
      if $scope.companyId and $scope.companyId isnt ''
        getTeams()
      $scope.$watch 'companyId', (newValue) ->
        if newValue and newValue isnt ''
          getTeams()
      
      console.log 'test'
  ]