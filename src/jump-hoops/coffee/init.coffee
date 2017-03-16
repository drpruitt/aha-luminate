angular.module 'ahaLuminateApp', [
  'ngSanitize'
  'ngTouch'
  'ui.bootstrap'
  'ahaLuminateControllers'
]

angular.module 'ahaLuminateControllers', []

angular.module 'ahaLuminateApp'
  .constant 'APP_INFO', 
    version: '1.0.0'

angular.module 'ahaLuminateApp'
  .constant 'APP_INFO', 
    version: '1.0.0'
    rootPath: do ->
      rootPath = '../'
      devBranch = luminateExtend.global.devBranch
      if devBranch and devBranch isnt ''
        rootPath += devBranch + '/'
      rootPath += 'aha-luminate/'

angular.module 'ahaLuminateApp'
  .run [
    '$rootScope'
    'APP_INFO'
    ($rootScope, APP_INFO) ->
      # get data from root element
      $dataRoot = angular.element '[data-aha-luminate-root]'
      $rootScope.apiKey = $dataRoot.data('api-key') if $dataRoot.data('api-key') isnt ''
      if not $rootScope.apiKey
        new Error 'AHA Luminate Framework: No Luminate Online API Key is defined.'
      $rootScope.consId = $dataRoot.data('cons-id') if $dataRoot.data('cons-id') isnt ''
      $rootScope.authToken = $dataRoot.data('auth-token') if $dataRoot.data('auth-token') isnt ''
      $rootScope.frId = $dataRoot.data('fr-id') if $dataRoot.data('fr-id') isnt ''
  ]

angular.element(document).ready ->
  appModules = [
    'ahaLuminateApp'
  ]
  
  try
    angular.module 'trPcApp'
    appModules.push 'trPcApp'
  catch error
  
  angular.bootstrap document, appModules