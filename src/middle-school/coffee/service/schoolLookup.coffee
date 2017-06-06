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
          url: luminateExtend.global.path.secure + 'CRTeamraiserAPI'
          data: 'v=1.0&api_key=' + $rootScope.apiKey + '&response_format=json&suppress_response_codes=true&method=getCompaniesByInfo&' + requestData
          headers:
            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
        .then (response) ->
          response
      
      getSchools: (callback) ->
        url = $sce.trustAsResourceUrl luminateExtend.global.path.nonsecure + 'PageServer?pagename=middle_school_search&pgwrap=n'
        $http.jsonp(url, jsonpCallbackParam: 'callback').then (response) ->
          if not response.data.success
            callback.failure response
          else
            callback.success decodeURIComponent(response.data.success.schools.replace(/\+/g, ' '))
  ]