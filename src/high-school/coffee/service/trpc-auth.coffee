angular.module 'trPcApp'
  .factory 'NgPcAuthService', [
    '$rootScope'
    'LuminateRESTService'
    ($rootScope, NgPcLuminateRESTService) ->
      getLoginState: ->
        NgPcLuminateRESTService.consRequest 'method=loginTest'
          .then (response) ->
            $rootScope.consId = response.data.loginResponse?.cons_id or -1
            response
      
      getAuthToken: ->
        NgPcLuminateRESTService.consRequest 'method=getLoginUrl'
          .then (response) ->
            $rootScope.authToken = response.data.getLoginUrlResponse.token
            response
      
      login: (requestData) ->
        dataString = 'method=login'
        dataString += '&' + requestData if requestData and requestData isnt ''
        NgPcLuminateRESTService.consRequest dataString
          .then (response) ->
            response
  ]