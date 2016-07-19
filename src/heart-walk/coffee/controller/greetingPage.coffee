angular.module 'ahaLuminateControllers'
  .controller 'GreetingPageCtrl', [
    '$scope'
    'TeamraiserParticipantService'
    'TeamraiserTeamService'
    'TeamraiserCompanyService'
    ($scope, TeamraiserParticipantService, TeamraiserTeamService, TeamraiserCompanyService) ->
      TeamraiserParticipantService.getParticipants 'first_name=' + encodeURIComponent('%%%') + '&list_sort_column=total&list_ascending=false', 
        error: () ->
          # TODO
        success: (response) ->
          topParticipants = response.getParticipantsResponse.participant
          topParticipants = [topParticipants] if not angular.isArray topParticipants
          $scope.topParticipants = topParticipants
      
      TeamraiserTeamService.getTeams 'list_sort_column=total&list_ascending=false', 
        error: () ->
          # TODO
        success: (response) ->
          topTeams = response.getTeamSearchByInfoResponse.team
          topTeams = [topTeams] if not angular.isArray topTeams
          $scope.topTeams = topTeams
      
      TeamraiserCompanyService.getCompanies 'list_sort_column=total&list_ascending=false', 
        error: () ->
          # TODO
        success: (response) ->
          topCompanies = response.getCompaniesResponse.company
          topCompanies = [topCompanies] if not angular.isArray topCompanies
          $scope.topCompanies = topCompanies
  ]