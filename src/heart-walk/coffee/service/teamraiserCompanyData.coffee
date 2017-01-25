angular.module 'ahaLuminateApp'
  .factory 'TeamraiserCompanyDataService', [
    '$rootScope'
    '$http'
    ($rootScope, $http) ->
      getCompanyData: ->
        $http
          method: 'GET'
          url: 'PageServer'
          data: 'pagename=getHeartwalkCompanyData&pgwrap=n&response_format=json&fr_id=' + $rootScope.frId
          headers:
            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
        .then (response) ->
          response
  ]