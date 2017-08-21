angular.module 'trPcApp'
  .factory 'NgPcTeamraiserReportsService', [
    '$rootScope'
    '$http'
    ($rootScope, $http) ->
      getDistrictDetailReport: (prevFrId, prevCompanyId) ->
        requestUrl = 'SPageServer?pagename='
        if $rootScope.participantRegistration.companyInformation?.isCompanyCoordinator isnt 'true'
          requestUrl += 'getDistrictHeartTeamDetailReport'
        else
          requestUrl += 'getDistrictHeartDistrictDetailReport'
        requestUrl += '&pgwrap=n&fr_id=' + $rootScope.frId
        if prevFrId
          requestUrl += '&prev_fr_id=' + prevFrId
        if prevCompanyId
          requestUrl += '&prev_company_id=' + prevCompanyId
        requestUrl += '&response_format=json'
        $http
          method: 'GET'
          url: requestUrl
        .then (response) ->
          response
  ]