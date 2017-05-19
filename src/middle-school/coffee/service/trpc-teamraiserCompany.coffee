angular.module 'trPcApp'
  .factory 'NgPcTeamraiserCompanyService', [
    '$rootScope'
    'NgPcLuminateRESTService'
    ($rootScope, NgPcLuminateRESTService) ->
      getCompanyList: (requestData, callback) ->
        dataString = 'method=getCompanyList'
        dataString += '&' + requestData if requestData and requestData isnt ''
        NgPcLuminateRESTService.teamraiserRequest dataString, false, true
          .then (response) ->
            response
      
      getCompanies: (requestData) ->
        dataString = 'method=getCompaniesByInfo'
        dataString += '&' + requestData if requestData and requestData isnt ''
        NgPcLuminateRESTService.teamraiserRequest dataString, false, true
          .then (response) ->
            response
      
      getCompany: ->
        this.getCompanies 'company_id=' + $rootScope.participantRegistration.companyInformation.companyId
          .then (response) ->
            companies = response.data.getCompaniesResponse?.company
            if not companies
              $rootScope.companyInfo = -1
            else
              companies = [companies] if not angular.isArray companies
              company = companies[0]
              $rootScope.companyInfo = company
            response
  ]