angular.module 'trPcApp', [
  'ngRoute'
  'ngCsv'
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
      $rootScope.consName = $embedRoot.data('cons-name') or ''
      $rootScope.teamMemberRegGoal = $embedRoot.data('team-member-reg-goal') or '0'
      $rootScope.participantRegGoal = $embedRoot.data('participant-reg-goal') or '0'
  ]

angular.element(document).ready ->
  if not angular.element(document).injector()
    angular.bootstrap document, [
      'trPcApp'
    ]