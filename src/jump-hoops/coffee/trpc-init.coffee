angular.module 'trPcApp', [
  'ngRoute'
  'ngSanitize'
  'ui.bootstrap'
  'textAngular'
  'trPcControllers'
]

angular.module 'trPcControllers', []

angular.module 'trPcApp'
  .constant 'NG_PC_APP_INFO', 
    version: '0.1.0'
    rootPath: do ->
      rootPath = ''
      devBranch = luminateExtend.global.devBranch
      if devBranch and devBranch isnt ''
        rootPath = '../' + devBranch + '/aha-luminate/'
      else
        rootPath = '../aha-luminate/'

angular.module 'trPcApp'
  .run [
    '$rootScope'
    'NG_PC_APP_INFO'
    ($rootScope, NG_PC_APP_INFO) ->
      # get data from embed container
      $embedRoot = angular.element '[data-embed-root]'
  ]

angular.element(document).ready ->
  if not angular.element(document).injector()
    angular.bootstrap document, [
      'trPcApp'
    ]