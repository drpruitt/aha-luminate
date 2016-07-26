angular.module 'ahaLuminateControllers'
  .controller 'CompanyPageCtrl', [
    '$scope'
    '$location'
    ($scope, $location) ->
      $scope.companyId = $location.absUrl().split('company_id=')[1].split('&')[0]
      
      $defaultCompanySummary = angular.element '.js--default-company-summary'
      companyAmountRaised = $defaultCompanySummary.find('.company-tally-container--amount .company-tally-ammount').text()
      if companyAmountRaised is ''
        companyAmountRaised = '0'
      companyGiftCount = $defaultCompanySummary.find('.company-tally-container--gift-count .company-tally-ammount').text()
      if companyGiftCount is ''
        companyGiftCount = '0'
      $scope.companyProgress = 
        amountRaised: companyAmountRaised
        goal: 0
        numDonations: companyGiftCount
  ]