angular.module 'trPcApp'
  .factory 'NgPcTeamraiserReportsService', [
    '$rootScope'
    '$http'
    ($rootScope, $http) ->
      getSchoolDetailReport: (frId = $rootScope.frId) ->
        pagename = 'getHighSchoolTeamDetailReport'
        if $rootScope.participantRegistration.companyInformation?.isCompanyCoordinator is 'true'
          pagename = 'getHighSchoolDetailReport'
        $http
          method: 'GET'
          url: 'SPageServer?pagename=' + pagename + '&pgwrap=n&fr_id=' + frId + '&response_format=json'
        .then (response) ->
          response
  ]