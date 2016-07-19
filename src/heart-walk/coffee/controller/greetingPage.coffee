angular.module 'ahaLuminateControllers'
  .controller 'GreetingPageCtrl', [
    '$scope'
    'TeamraiserParticipantService'
    'TeamraiserTeamService'
    'TeamraiserCompanyService'
    ($scope, TeamraiserParticipantService, TeamraiserTeamService, TeamraiserCompanyService) ->
      TeamraiserParticipantService.getParticipants 'first_name=' + encodeURIComponent('%%%') + '&list_sort_column=total&list_ascending=false', 
        error: () ->
          $scope.topParticipants = []
        success: (response) ->
          topParticipants = response.getParticipantsResponse.participant || []
          topParticipants = [topParticipants] if not angular.isArray topParticipants
          $scope.topParticipants = topParticipants
          if not $scope.$$phase
            $scope.$apply()
      
      TeamraiserTeamService.getTeams 'list_sort_column=total&list_ascending=false', 
        error: () ->
          $scope.topTeams = []
        success: (response) ->
          topTeams = response.getTeamSearchByInfoResponse.team || []
          topTeams = [topTeams] if not angular.isArray topTeams
          $scope.topTeams = topTeams
          if not $scope.$$phase
            $scope.$apply()
      
      TeamraiserCompanyService.getCompanies 'list_sort_column=total&list_ascending=false', 
        error: () ->
          $scope.topCompanies = []
        success: (response) ->
          topCompanies = response.getCompaniesResponse.company || []
          topCompanies = [topCompanies] if not angular.isArray topCompanies
          $scope.topCompanies = topCompanies
          if not $scope.$$phase
            $scope.$apply()
  ]