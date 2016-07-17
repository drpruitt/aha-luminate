angular.module 'ahaLuminateControllers'
  .controller 'GreetingPageCtrl', [
    '$scope'
    'TeamraiserParticipantService'
    'TeamraiserTeamService'
    'TeamraiserCompanyService'
    ($scope, TeamraiserParticipantService, TeamraiserTeamService, TeamraiserCompanyService) ->
      TeamraiserParticipantService.getParticipants 'fr_id=&first_name=' + encodeURIComponent('%%%') + '&list_sort_column=total&list_ascending=false'
        .then (response) ->
          topParticipants = response.data.getParticipantsResponse.participant
          topParticipants = [topParticipants] if not angular.isArray topParticipants
          $scope.topParticipants = topParticipants
      
      TeamraiserTeamService.getTeams 'fr_id=&list_sort_column=total&list_ascending=false'
        .then (response) ->
          topTeams = response.data.getTeamSearchByInfoResponse.team
          topTeams = [topTeams] if not angular.isArray topTeams
          $scope.topTeams = topTeams
      
      TeamraiserCompanyService.getCompanies 'fr_id=&list_sort_column=total&list_ascending=false'
        .then (response) ->
          topCompanies = response.data.getCompaniesResponse.company
          topCompanies = [topCompanies] if not angular.isArray topCompanies
          $scope.topCompanies = topCompanies
  ]