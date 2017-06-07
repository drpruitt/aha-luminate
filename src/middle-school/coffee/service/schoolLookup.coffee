angular.module 'ahaLuminateApp'
  .factory 'SchoolLookupService', [
    '$rootScope'
    '$http'
    '$sce'
    ($rootScope, $http, $sce) ->
      getSchoolCompanies: (requestData) ->
        # requestUrl = '/system/proxy.jsp?__proxyURL=' + encodeURIComponent(luminateExtend.global.path.secure + 'CRTeamraiserAPI')
        requestUrl = '/system/proxy.jsp?__proxyURL=' + encodeURIComponent('https://secure3.convio.net/heartdev/site/CRTeamraiserAPI')
        if luminateExtend.global.tablePrefix is 'heartdev'
          requestUrl = 'https://secure3.convio.net/heartdev/site/CRTeamraiserAPI'
        $http
          method: 'POST'
          url: $sce.trustAsResourceUrl requestUrl
          data: 'v=1.0&api_key=' + $rootScope.apiKey + '&response_format=json&suppress_response_codes=true&method=getCompaniesByInfo&event_type=' + encodeURIComponent('Middle School') + '&' + requestData
          headers:
            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
      
      getSchoolData: ->
        # requestUrl = '/system/proxy.jsp?__proxyURL=' + encodeURIComponent(luminateExtend.global.path.secure + 'SPageServer?pagename=getJumpHoopsSchoolSearchData&pgwrap=n')
        requestUrl = '/system/proxy.jsp?__proxyURL=' + encodeURIComponent('https://secure3.convio.net/heartdev/site/SPageServer?pagename=getJumpHoopsSchoolSearchData&pgwrap=n')
        if luminateExtend.global.tablePrefix is 'heartdev'
          requestUrl = 'https://secure3.convio.net/heartdev/site/SPageServer?pagename=getJumpHoopsSchoolSearchData&pgwrap=n'
        $http
          method: 'GET'
          url: $sce.trustAsResourceUrl requestUrl
          headers:
            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
  ]