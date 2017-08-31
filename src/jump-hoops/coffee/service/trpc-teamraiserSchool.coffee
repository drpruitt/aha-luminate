angular.module 'ahaLuminateApp'
  .factory 'NgPcTeamraiserSchoolService', [
    '$rootScope'
    '$http'
    '$sce'
    ($rootScope, $http, $sce) ->
      updateSchoolGoal: (requestData, scope, callback) ->
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
            company_formvars
            #jQuery.post 'NTM', company_formvars
            $http
              method: 'POST'
              url: $sce.trustAsResourceUrl('NTM')
              data: company_formvars
              headers:
                'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
  ]
