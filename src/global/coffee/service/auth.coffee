angular.module 'ahaLuminateApp'
  .factory 'AuthService', [
    'LuminateRESTService'
    (LuminateRESTService) ->
      login: (requestData, callback) ->
        dataString = 'method=login'
        dataString += '&' + requestData if requestData and requestData isnt ''
        LuminateRESTService.luminateExtendConsRequest dataString, false, callback
  ]