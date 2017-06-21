angular.module 'trPcApp'
  .factory 'NgPcTeamraiserReportsService', [
    '$rootScope'
    '$http'
    ($rootScope, $http) ->
      getSchoolDetailReport: ->
        $http
          method: 'GET'
          url: 'SPageServer?pagename=getMiddleSchoolDetailReport&pgwrap=n&fr_id=' + $rootScope.frId + '&response_format=json'
        .then (response) ->
          response
  ]