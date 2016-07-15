angular.module 'ahaLuminateApp', [
  'ngSanitize'
  'ui.bootstrap'
  'ahaLuminateControllers'
]

angular.module 'ahaLuminateControllers', []

angular.module 'ahaLuminateApp'
  .constant 'APP_INFO', 
    version: '1.0.0'

angular.module 'ahaLuminateApp'
  .run [
    '$rootScope'
    'APP_INFO'
    ($rootScope, APP_INFO) ->
      # get data from embed container
      $embedRoot = angular.element '[data-embed-root]'
      appVersion = $embedRoot.data('app-version') if $embedRoot.data('app-version') isnt ''
      $rootScope.apiKey = $embedRoot.data('api-key') if $embedRoot.data('api-key') isnt ''
      if not $rootScope.apiKey
        new Error 'AHA Luminate Framework: No Luminate Online API Key is defined.'
      $rootScope.consId = $embedRoot.data('cons-id') if $embedRoot.data('cons-id') isnt ''
      $rootScope.authToken = $embedRoot.data('auth-token') if $embedRoot.data('auth-token') isnt ''
      $rootScope.frId = $embedRoot.data('fr-id') if $embedRoot.data('fr-id') isnt ''
  ]

angular.element(document).ready ->
  angular.bootstrap document, ['ahaLuminateApp']