angular.module 'ahaLuminateControllers'
  .controller 'CompanyPageCtrl', [
    '$scope'
    '$location'
    'TeamraiserCompanyService'
    'TeamraiserTeamService'
    'TeamraiserParticipantService'
    ($scope, $location, TeamraiserCompanyService, TeamraiserTeamService, TeamraiserParticipantService) ->
      $scope.companyId = $location.absUrl().split('company_id=')[1].split('&')[0]
      
      $defaultCompanySummary = angular.element '.js--default-company-summary'
      companyGiftCount = $defaultCompanySummary.find('.company-tally-container--gift-count .company-tally-ammount').text()
      if companyGiftCount is ''
        companyGiftCount = '0'
      $scope.companyProgress = 
        numDonations: companyGiftCount
      
      setCompanyFundraisingProgress = (amountRaised, goal) ->
        $scope.companyProgress.amountRaised = amountRaised or '0'
        $scope.companyProgress.goal = goal or '0'
        if not $scope.$$phase
          $scope.$apply()
      TeamraiserCompanyService.getCompanies 'company_id=' + $scope.companyId, 
        error: ->
          setCompanyFundraisingProgress()
        success: (response) ->
          companyInfo = response.getCompaniesResponse?.company
          if not companyInfo
            setCompanyFundraisingProgress()
          else
            setCompanyFundraisingProgress companyInfo.amountRaised, companyInfo.goal
      
      $defaultCompanyHierarchy = angular.element '.js--default-company-hierarchy'
      $childCompanyLinks = $defaultCompanyHierarchy.find('.trr-td a')
      childCompanyIds = []
      angular.forEach $childCompanyLinks, (childCompanyLink) ->
        childCompanyUrl = angular.element(childCompanyLink).attr('href')
        if childCompanyUrl.indexOf('company_id=') isnt -1
          childCompanyIds.push childCompanyUrl.split('company_id=')[1].split('&')[0]
      numCompanies = childCompanyIds.length + 1
      
      setCompanyNumTeams = (numTeams) ->
        $scope.companyProgress.numTeams = numTeams or 0
        if not $scope.$$phase
          $scope.$apply()
      numCompaniesTeamRequestComplete = 0
      numTeams = 0
      TeamraiserTeamService.getTeams 'team_company_id=' + $scope.companyId + '&list_page_size=5', 
        error: ->
          numCompaniesTeamRequestComplete++
          if numCompaniesTeamRequestComplete is numCompanies
            setCompanyNumTeams numTeams
        success: (response) ->
          companyTeams = response.getTeamSearchByInfoResponse?.team
          if companyTeams
            companyTeams = [companyTeams] if not angular.isArray companyTeams
            numTeams += Number response.getTeamSearchByInfoResponse.totalNumberResults
          numCompaniesTeamRequestComplete++
          if numCompaniesTeamRequestComplete is numCompanies
            setCompanyNumTeams numTeams
      angular.forEach childCompanyIds, (childCompanyId) ->
        TeamraiserTeamService.getTeams 'team_company_id=' + childCompanyId + '&list_page_size=5', 
          error: ->
            numCompaniesTeamRequestComplete++
            if numCompaniesTeamRequestComplete is numCompanies
              setCompanyNumTeams numTeams
          success: (response) ->
            companyTeams = response.getTeamSearchByInfoResponse?.team
            if companyTeams
              companyTeams = [companyTeams] if not angular.isArray companyTeams
              numTeams += Number response.getTeamSearchByInfoResponse.totalNumberResults
            numCompaniesTeamRequestComplete++
            if numCompaniesTeamRequestComplete is numCompanies
              setCompanyNumTeams numTeams
      
      setCompanyNumParticipants = (numParticipants) ->
        $scope.companyProgress.numParticipants = numParticipants or 0
        if not $scope.$$phase
          $scope.$apply()
      numCompaniesParticipantRequestComplete = 0
      numParticipants = 0
      TeamraiserParticipantService.getParticipants 'team_name=' + encodeURIComponent('%') + '&list_filter_column=team.company_id&list_filter_text=' + $scope.companyId + '&list_page_size=5', 
        error: ->
          numCompaniesParticipantRequestComplete++
          if numCompaniesParticipantRequestComplete is numCompanies
            setCompanyNumParticipants numParticipants
        success: (response) ->
          companyParticipants = response.getParticipantsResponse?.participant
          if companyParticipants
            companyParticipants = [companyParticipants] if not angular.isArray companyParticipants
            numParticipants += Number response.getParticipantsResponse.totalNumberResults
          numCompaniesParticipantRequestComplete++
          if numCompaniesParticipantRequestComplete is numCompanies
            setCompanyNumParticipants numParticipants
      angular.forEach childCompanyIds, (childCompanyId) ->
        TeamraiserParticipantService.getParticipants 'team_name=' + encodeURIComponent('%') + '&list_filter_column=team.company_id&list_filter_text=' + childCompanyId + '&list_page_size=5', 
          error: ->
            numCompaniesParticipantRequestComplete++
            if numCompaniesParticipantRequestComplete is numCompanies
              setCompanyNumParticipants numParticipants
          success: (response) ->
            companyParticipants = response.getParticipantsResponse?.participant
            if companyParticipants
              companyParticipants = [companyParticipants] if not angular.isArray companyParticipants
              numParticipants += Number response.getParticipantsResponse.totalNumberResults
            numCompaniesParticipantRequestComplete++
            if numCompaniesParticipantRequestComplete is numCompanies
              setCompanyNumParticipants numParticipants
  ]