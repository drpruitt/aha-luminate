angular.module 'ahaLuminateApp'
  .factory 'SchoolLookupService', [
    '$rootScope'
    '$http'
    '$sce'
    'SchoolSearchService'
    ($rootScope, $http, $sce, $SchoolSearchService) ->
      getSchoolCompanies: (requestData) ->
        requestUrl = '/system/proxy.jsp?__proxyURL=' + encodeURIComponent(luminateExtend.global.path.secure + 'CRTeamraiserAPI')
        if window.location.href.indexOf(luminateExtend.global.path.secure) is 0
          requestUrl = 'CRTeamraiserAPI'
        $http
          method: 'POST'
          url: $sce.trustAsResourceUrl(requestUrl)
          data: 'v=1.0&api_key=' + $rootScope.apiKey + '&response_format=json&suppress_response_codes=true&method=getCompaniesByInfo&event_type=' + encodeURIComponent('YM Kids Heart Challenge') + '&' + requestData
          headers:
            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'

      getSchoolData: ->
        requestUrl = luminateExtend.global.path.nonsecure
        if window.location.protocol is 'https:'
          requestUrl = luminateExtend.global.path.secure + 'S'
        requestUrl += 'PageServer?pagename=getYmKhcSchoolSearchData&pgwrap=n'
        $http.jsonp($sce.trustAsResourceUrl(requestUrl), jsonpCallbackParam: 'callback')
          .then (response) ->
            response
          , (response) ->
            response
            
      getGeoSchoolData = (e, callback) ->
        url = '//hearttools.heart.org/ym-khc-schools/schoolProcessing.php?method=getSchoolsByDistance&lat=' + e.coords.latitude + '&long=' + e.coords.longitude
        if $rootScope.tablePrefix == 'heartdev'
          url += '&table=dev'
        $http.jsonp($sce.trustAsResourceUrl(url), jsonpCallbackParam: 'callback')
          .then (response) ->
            callback.success response
          , (response) ->
            callback.failure response
      
      #ask for current location and search for closest schools
      $SchoolSearchService.getLocation()
  ]
