angular.module 'ahaLuminateControllers'
  .controller 'CompanyPageCtrl', [
    '$scope'
    '$location'
    'TeamraiserCompanyService'
    ($scope, $location, TeamraiserCompanyService) ->
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
  ]