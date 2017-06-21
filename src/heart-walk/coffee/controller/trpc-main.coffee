angular.module 'trPcControllers'
  .controller 'NgPcMainCtrl', [
    '$rootScope'
    '$scope'
    '$location'
    '$timeout'
    'LocaleService'
    ($rootScope, $scope, $location, $timeout, LocaleService) ->
      $rootScope.$location = $location
      
      $rootScope.baseUrl = $location.absUrl().split('#')[0]
      
      LocaleService.setLocale $rootScope.locale
      
      $rootScope.changeLocale = ->
        LocaleService.setLocale()
      
      $scope.$on '$viewContentLoaded', ->
        addThisChecks = 0
        checkAddThis = ->
          addThisChecks++
          if angular.element('.addthis_toolbox').length > 0
            addthis.toolbox '.addthis_toolbox'
          else if addThisChecks < 13
            $timeout checkAddThis, 250
        checkAddThis()
  ]