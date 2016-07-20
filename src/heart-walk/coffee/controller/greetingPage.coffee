angular.module 'ahaLuminateControllers'
  .controller 'GreetingPageCtrl', [
    '$scope'
    'TeamraiserParticipantService'
    'TeamraiserTeamService'
    'TeamraiserCompanyService'
    ($scope, TeamraiserParticipantService, TeamraiserTeamService, TeamraiserCompanyService) ->
      $scope.topParticipants = {}
      setTopParticipants = (participants) ->
        $scope.topParticipants.participants = participants
        if not $scope.$$phase
          $scope.$apply()
      TeamraiserParticipantService.getParticipants 'first_name=' + encodeURIComponent('%%%') + '&list_sort_column=total&list_ascending=false', 
        error: () ->
          setTopParticipants []
        success: (response) ->
          topParticipants = response.getParticipantsResponse.participant || []
          topParticipants = [topParticipants] if not angular.isArray topParticipants
          # TODO: remove participants with null names
          setTopParticipants topParticipants
      
      $scope.topTeams = {}
      setTopTeams = (teams) ->
        $scope.topTeams.teams = teams
        if not $scope.$$phase
          $scope.$apply()
      TeamraiserTeamService.getTeams 'list_sort_column=total&list_ascending=false', 
        error: () ->
          setTopTeams []
        success: (response) ->
          topTeams = response.getTeamSearchByInfoResponse.team || []
          topTeams = [topTeams] if not angular.isArray topTeams
          setTopTeams topTeams
      
      $scope.topCompanies = {}
      setTopCompanies = (companies) ->
        $scope.topCompanies.companies = companies
        if not $scope.$$phase
          $scope.$apply()
      TeamraiserCompanyService.getCompanies 'list_sort_column=total&list_ascending=false', 
        error: () ->
          setTopCompanies []
        success: (response) ->
          topCompanies = response.getCompaniesResponse.company || []
          topCompanies = [topCompanies] if not angular.isArray topCompanies
          setTopCompanies topCompanies
  ]