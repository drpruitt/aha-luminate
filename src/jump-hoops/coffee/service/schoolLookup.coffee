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
          data: 'v=1.0&api_key=' + $rootScope.apiKey + '&response_format=json&suppress_response_codes=true&method=getCompaniesByInfo&' + requestData
          headers:
            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
      
      getSchoolData: (companyIds) ->
        requestData = ''
        angular.forEach companyIds, (companyId, companyIdIndex) ->
          if requestData isnt ''
            requestData += '&'
          requestData += 'company_id_' + (companyIdIndex + 1) + '=' + companyId
        $http
          method: 'GET'
          # url: '/system/proxy.jsp?__proxyURL=' + encodeURIComponent(luminateExtend.global.path.secure + 'PageServer?pagename=getJumpHoopsSchoolSearchData&pgwrap=n&' + requestData)
          url: 'https://secure3.convio.net/heartdev/site/SPageServer?pagename=getJumpHoopsSchoolSearchData&pgwrap=n&' + requestData
          headers:
            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
  ]