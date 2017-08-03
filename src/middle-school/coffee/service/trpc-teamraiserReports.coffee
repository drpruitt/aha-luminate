angular.module 'trPcApp'
  .factory 'NgPcTeamraiserReportsService', [
    '$rootScope'
    '$http'
    ($rootScope, $http) ->
      getSchoolDetailReport: (frId = $rootScope.frId) ->
        $http
          method: 'GET'
          url: 'SPageServer?pagename=getMiddleSchoolDetailReport&pgwrap=n&fr_id=' + frId + '&response_format=json'
        .then (response) ->
          response
  ]