angular.module 'trPcApp'
  .factory 'TeamraiserCompanyService', [
    '$rootScope'
    '$http'
    'LuminateRESTService'
    ($rootScope, $http, LuminateRESTService) ->
      getCompanyList: (requestData, callback) ->
        dataString = 'method=getCompanyList'
        dataString += '&' + requestData if requestData and requestData isnt ''
        LuminateRESTService.teamraiserRequest dataString, false, true
          .then (response) ->
            response
      
      getCompanies: (requestData) ->
        dataString = 'method=getCompaniesByInfo'
        dataString += '&' + requestData if requestData and requestData isnt ''
        LuminateRESTService.teamraiserRequest dataString, false, true
          .then (response) ->
            response
      
      getCompany: ->
        this.getCompanies 'company_id=' + $rootScope.participantRegistration.companyInformation.companyId

      updateCompanyGoal: (requestData, scope, callback) ->
        $http.get('NTM?tr.ntmgmt=company_edit&mfc_pref=T&action=edit_company&company_id=' + scope.participantRegistration.companyInformation.companyId + '&fr_id=' + $rootScope.frId)
          .then (response) ->
            company_page = jQuery(response.data)
            company_formvars = jQuery(company_page).find('form').serializeArray()
            jQuery.each company_formvars, (i, key) ->
               if key['name'] == 'goalinput'
                  company_formvars[i]['value'] = requestData

            company_formvars.push
               'name': 'pstep_next'
               'value': 'next'

            #jQuery.post 'NTM', company_formvars
            params = ''
            jQuery.each company_formvars, (i) ->
              params += (if i > 0 then '&' else '') + @name + '=' + @value
            $http
              method: 'POST'
              url: 'NTM'
              data: params
              headers:
                'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'  
]
