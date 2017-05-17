angular.module 'ahaLuminateControllers'
  .controller 'RegistrationUtypeCtrl', [
    '$rootScope'
    '$scope'
    'TeamraiserCompanyService'
    ($rootScope, $scope, TeamraiserCompanyService) ->
      regCompanyId = luminateExtend.global.regCompanyId
      $rootScope.companyName = ''
      TeamraiserCompanyService.getCompanies 'company_id=' + $scope.companyId,
        error: ->
          # TODO
        success: (response) ->
          companies = response.getCompaniesResponse.company
          if not companies
            # TODO
          else
            companies = [companies] if not angular.isArray companies
            companyInfo = companies[0]
            $rootScope.companyName = companyInfo.companyName
      
      $scope.toggleUserType = (userType) ->
        $scope.userType = userType
        if userType is 'new'
          angular.element('.js--default-utype-new-form').submit()
          false
      
      $scope.submitUtypeLogin = ->
        angular.element('.js--default-utype-existing-form').submit()
        false
      
      $scope.toggleForgotLogin = (showHide) ->
        $scope.showForgotLogin = showHide is 'show'
      
      $scope.submitForgotLogin = ->
        angular.element('.js--default-utype-send-username-form').submit()
        false
  ]