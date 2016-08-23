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
      TeamraiserCompanyService.getCompanyList 'include_all_companies=true', 
        error: () ->
          setTopCompanies []
        success: (response) ->
          companyItems = response.getCompanyListResponse.companyItem || []
          companyItems = [companyItems] if not angular.isArray companyItems
          rootAncestorCompanyIds = []
          angular.forEach companyItems, (companyItem) ->
            if companyItem.parentOrgEventId is '0'
              rootAncestorCompanyIds.push companyItem.companyId
          
          TeamraiserCompanyService.getCompanies 'list_sort_column=total&list_ascending=false&list_page_size=500', 
            error: () ->
              setTopCompanies []
            success: (response) ->
              companies = response.getCompaniesResponse.company || []
              companies = [companies] if not angular.isArray companies
              topCompanies = []
              angular.forEach companies, (company) ->
                if rootAncestorCompanyIds.indexOf(company.companyId) > -1
                  topCompanies.push company
              topCompanies.sort (a, b) ->
                Number(b.amountRaised) - Number(a.amountRaised)
              setTopCompanies topCompanies
  ]