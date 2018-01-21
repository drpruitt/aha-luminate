angular.module 'trPcApp'
  .factory 'NgPcTeamraiserReportsService', [
    '$rootScope'
    '$http'
    ($rootScope, $http) ->
      getDistrictDetailReport: (prev1FrId, prevCompanyId) ->
        requestUrl = 'SPageServer?pagename='
        if $rootScope.participantRegistration.companyInformation?.isCompanyCoordinator isnt 'true'
          requestUrl += 'getDistrictHeartTeamDetailReport'
        else
          requestUrl += 'getDistrictHeartDistrictDetailReport'
        requestUrl += '&pgwrap=n&fr_id=' + $rootScope.frId
        if prev1FrId
          requestUrl += '&prev_fr_id=' + prev1FrId
        if prevCompanyId
          requestUrl += '&prev_company_id=' + prevCompanyId
        requestUrl += '&response_format=json'
        $http
          method: 'GET'
          url: requestUrl
        .then (response) ->
          response
  ]