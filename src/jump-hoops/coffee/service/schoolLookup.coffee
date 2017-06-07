angular.module 'ahaLuminateApp'
  .factory 'SchoolLookupService', [
    '$rootScope'
    '$http'
    '$sce'
    ($rootScope, $http, $sce) ->
      getSchoolCompanies: (requestData) ->
        $http
          method: 'POST'
          # url: '/system/proxy.jsp?__proxyURL=' + encodeURIComponent(luminateExtend.global.path.secure + 'CRTeamraiserAPI')
          url: 'https://secure3.convio.net/heartdev/site/CRTeamraiserAPI'
          data: 'v=1.0&api_key=' + $rootScope.apiKey + '&response_format=json&suppress_response_codes=true&method=getCompaniesByInfo&event_type=' + encodeURIComponent('Jump Hoops') + '&' + requestData
          headers:
            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
      
      getSchoolData: ->
        $http
          method: 'GET'
          # url: '/system/proxy.jsp?__proxyURL=' + encodeURIComponent(luminateExtend.global.path.secure + 'SPageServer?pagename=getJumpHoopsSchoolSearchData&pgwrap=n')
          url: 'https://secure3.convio.net/heartdev/site/SPageServer?pagename=getJumpHoopsSchoolSearchData&pgwrap=n'
          headers:
            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
  ]