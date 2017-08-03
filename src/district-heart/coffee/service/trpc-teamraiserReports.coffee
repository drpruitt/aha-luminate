angular.module 'trPcApp'
  .factory 'NgPcTeamraiserReportsService', [
    '$rootScope'
    '$http'
    ($rootScope, $http) ->
      getDistrictDetailReport: (frId = $rootScope.frId, companyId = $rootScope.participantRegistration.companyInformation.companyId) ->
        pagename = 'getDistrictHeartTeamDetailReport'
        if $rootScope.participantRegistration.companyInformation?.isCompanyCoordinator is 'true'
          pagename = 'getDistrictHeartDistrictDetailReport'
        $http
          method: 'GET'
          url: 'SPageServer?pagename=' + pagename + '&pgwrap=n&fr_id=' + frId + '&company_id=' + companyId + '&response_format=json'
        .then (response) ->
          response
  ]