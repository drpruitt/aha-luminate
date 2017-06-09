angular.module 'trPcApp'
  .config [
    '$compileProvider'
    ($compileProvider) ->
      $compileProvider.aHrefSanitizationWhitelist /^\s*(https?|mailto|sms):/
  ]