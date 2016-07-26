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
      
      setCompanyProgress = (amountRaised, goal) ->
        $scope.companyProgress.amountRaised = amountRaised or '0'
        $scope.companyProgress.goal = goal or '0'
        if not $scope.$$phase
          $scope.$apply()
      
      TeamraiserCompanyService.getCompanies 'company_id=' + $scope.companyId, 
        error: ->
          setCompanyProgress()
        success: (response) ->
          companyInfo = response.getCompaniesResponse?.company
          if not companyInfo
            setCompanyProgress()
          else
            setCompanyProgress companyInfo.amountRaised, companyInfo.goal
      
      $defaultCompanyHierarchy = angular.element '.js--default-company-hierarchy'
      $childCompanyLinks = $defaultCompanyHierarchy.find('.trr-td a')
      childCompanyIds = []
      angular.forEach $childCompanyLinks, (childCompanyLink) ->
        childCompanyUrl = angular.element(childCompanyLink).attr('href')
        if childCompanyUrl.indexOf('company_id=') isnt -1
          childCompanyIds.push childCompanyUrl.split('company_id=')[1].split('&')[0]
      
      TeamraiserTeamService.getTeams 'team_company_id=' + $scope.companyId, 
        error: ->
          # TODO
        success: ->
          # TODO
      
      angular.forEach childCompanyIds, (childCompanyId) ->
        TeamraiserTeamService.getTeams 'team_company_id=' + childCompanyId, 
          error: ->
            # TODO
          success: ->
            # TODO
  ]