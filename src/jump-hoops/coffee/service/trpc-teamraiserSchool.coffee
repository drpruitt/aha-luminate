angular.module 'ahaLuminateApp'
  .factory 'NgPcTeamraiserSchoolService', [
    '$rootScope'
    '$http'
    '$sce'
    ($rootScope, $http, $sce) ->
      updateSchoolGoal: (requestData, scope, callback) ->
        #jQuery.get 'https://www2.heart.org/site/NTM?tr.ntmgmt=company_edit&company_id=' + scope.participantRegistration.companyInformation.companyId + '&mfc_pref=T&action=edit_company&fr_id=' + $rootScope.frId, (data) ->
        #    company_page = jQuery(data)
        #    company_formvars = jQuery(company_page).find('form').serializeArray()
        #    jQuery.each company_formvars, (i, key) ->
        #       if key['name'] == 'goalinput'
        #          company_formvars[i]['value'] = requestData
        #       return
        #    company_formvars.push
        #       'name': 'pstep_next'
        #       'value': 'next'
        #    jQuery.post 'https://www2.heart.org/site/NTM', company_formvars
        #    callback.success response
        $http.get('NTM?tr.ntmgmt=company_edit&mfc_pref=T&action=edit_company&company_id=' + scope.participantRegistration.companyInformation.companyId + '&fr_id=' + $rootScope.frId)
          .then (response) ->
            console.log(response)
            company_page = jQuery(response)
            company_formvars = jQuery(company_page).find('form').serializeArray()
            console.log(company_formvars)
            jQuery.each company_formvars, (i, key) ->
               if key['name'] == 'goalinput'
                  company_formvars[i]['value'] = requestData

            company_formvars.push
               'name': 'pstep_next'
               'value': 'next'
            company_formvars
]
