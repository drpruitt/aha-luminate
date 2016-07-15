angular.module 'ahaLuminateApp'
  .factory 'LuminateRESTService', [
    '$rootScope'
    '$http'
    'APP_INFO'
    ($rootScope, $http, APP_INFO) ->
      request: (apiServlet, requestData, includeAuth, includeFrId) ->
        if not requestData
          # TODO
        else
          if not $rootScope.apiKey
            # TODO
          else
            requestData += '&v=1.0&api_key=' + $rootScope.apiKey + '&response_format=json&suppress_response_codes=true&ng_tr_pc_v=' + APP_INFO.version
            if includeAuth and not $rootScope.authToken
              # TODO
            else
              if includeAuth
                requestData += '&auth=' + $rootScope.authToken
              if includeFrId
                requestData += '&fr_id=' + $rootScope.frId + '&s_trID=' + $rootScope.frId
              if $rootScope.locale
                requestData += '&s_locale=' + $rootScope.locale
              $http
                method: 'POST'
                url: apiServlet
                data: requestData
                headers:
                  'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
              .then (response) ->
                response
      
      teamraiserRequest: (requestData, includeAuth, includeFrId) ->
        this.request 'CRTeamraiserAPI', requestData, includeAuth, includeFrId
  ]