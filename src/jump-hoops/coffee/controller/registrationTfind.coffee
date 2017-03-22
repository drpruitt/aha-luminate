angular.module 'ahaLuminateControllers'
  .controller 'RegistrationTfindCtrl', [
    '$scope'
    'TeamraiserTeamService'
    ($scope, TeamraiserTeamService) ->
      TeamraiserTeamService.getTeams 'team_company_id=&list_page_size=500',
        error: ->
          # TODO
        success: (response) ->
          teams = response.getTeamSearchByInfoResponse.team
          teams = [teams] if not angular.isArray teams
  ]