angular.module 'trPcApp'
  .factory 'NgPcTeamraiserReportsService', [
    '$rootScope'
    '$http'
    ($rootScope, $http) ->
      getSchoolDetailReport: (frId = $rootScope.frId, companyId = $rootScope.participantRegistration.companyInformation.companyId) ->
        $http
          method: 'GET'
          url: 'SPageServer?pagename=getMiddleSchoolDetailReport&pgwrap=n&fr_id=' + frId + '&company_id=' + companyId + '&response_format=json'
        .then (response) ->
          response
  ]