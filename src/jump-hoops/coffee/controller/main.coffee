angular.module 'ahaLuminateControllers'
  .controller 'MainCtrl', [
    '$scope'
    ($scope) ->
      $scope.toggleLoginMenu = ->
        console.log 'toggleLoginMenu()'
        if $scope.loginMenuOpen
          delete $scope.loginMenuOpen
        else
          $scope.loginMenuOpen = true
      
      angular.element('body').on 'click', (event) ->
        console.log $scope.loginMenuOpen, event.target
        if $scope.loginMenuOpen and angular.element(event.target).closest('.ym-header-login').length is 0
          $scope.toggleLoginMenu()
        console.log $scope.loginMenuOpen
      
      $scope.submitHeaderLogin = ->
        # TODO
      
      $scope.toggleSiteMenu = ->
        if $scope.siteMenuOpen
          delete $scope.siteMenuOpen
        else
          $scope.siteMenuOpen = true
      
      angular.element('body').on 'click', (event) ->
        if $scope.siteMenuOpen and angular.element(event.target).closest('.ym-site-menu').length is 0
          $scope.toggleSiteMenu()
  ]