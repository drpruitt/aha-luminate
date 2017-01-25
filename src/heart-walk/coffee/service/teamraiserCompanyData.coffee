angular.module 'ahaLuminateApp'
  .factory 'TeamraiserCompanyDataService', [
    '$rootScope'
    '$http'
    ($rootScope, $http) ->
      getCompanyData: ->
        $http.get 'PageServer?pagename=getHeartwalkCompanyData&pgwrap=n&response_format=json&fr_id=' + $rootScope.frId
          .then (response) ->
            response
  ]