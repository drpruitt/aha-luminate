angular.module 'ahaLuminateApp'
  .factory 'NgPcTeamraiserSchoolService', [
    '$rootScope'
    '$http'
    '$sce'
    ($rootScope, $http, $sce) ->
      updateSchoolGoal: (requestData, scope, callback) ->
        console.log(scope)
        jQuery.get 'https://www2.heart.org/site/NTM?tr.ntmgmt=company_edit&company_id=' + scope.participantRegistration.companyInformation.companyId + '&mfc_pref=T&action=edit_company&fr_id=' + $rootScope.frId, (data) ->
            company_page = jQuery(data)
            company_formvars = jQuery(company_page).find('form').serializeArray()
            jQuery.each company_formvars, (i, key) ->
               if key['name'] == 'goalinput'
                  company_formvars[i]['value'] = requestData
               return
            company_formvars.push
               'name': 'pstep_next'
               'value': 'next'
            jQuery.post 'https://www2.heart.org/site/NTM', formvars
            callback.success response
        #$http.get('https://www2.heart.org/site/NTM?tr.ntmgmt=company_edit&mfc_pref=T&action=edit_company&company_id=' + scope.participantRegistration.companyInformation.companyId + '&fr_id=' + $rootScope.frId)
        #  .then (response) ->
        #    callback.success response
        #  , (response) ->
        #    callback.failure response
]
