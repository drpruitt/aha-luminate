angular.module 'ahaLuminateControllers'
  .controller 'MainCtrl', [
    '$scope'
    '$httpParamSerializer'
    'AuthService'
    'TeamraiserParticipantService'
    '$anchorScroll'
    '$location'
    ($scope, $httpParamSerializer, AuthService, TeamraiserParticipantService, $anchorScroll, $location) ->
      $dataRoot = angular.element '[data-aha-luminate-root]'
      consId = $dataRoot.data('cons-id') if $dataRoot.data('cons-id') isnt ''
      $scope.numberEvents = 0
      $scope.regEventId = ''
      
      if consId
        TeamraiserParticipantService.getRegisteredTeamraisers 'cons_id=' + consId + '&event_type=' + encodeURIComponent('Jump Hoops'),
          success: (response) ->
            teamraisers = response.getRegisteredTeamraisersResponse.teamraiser
            if not teamraisers
              $scope.numberEvents = 0
            else
              teamraisers = [teamraisers] if not angular.isArray teamraisers
              $scope.numberEvents = teamraisers.length
            if $scope.numberEvents is 0
              # TODO
            else
              if $scope.numberEvents is 1
                $scope.regEventId = teamraisers[0].id
      
      $scope.toggleLoginMenu = ->
        if $scope.loginMenuOpen
          delete $scope.loginMenuOpen
        else
          $scope.loginMenuOpen = true
      
      angular.element('body').on 'click', (event) ->
        if $scope.loginMenuOpen and angular.element(event.target).closest('.ym-header-login').length is 0
          $scope.toggleLoginMenu()
        if not $scope.$$phase
          $scope.$apply()
      
      $scope.headerLoginInfo = 
        user_name: ''
        password: ''
      
      $scope.submitHeaderLogin = ->
        AuthService.login $httpParamSerializer($scope.headerLoginInfo), 
          error: ->
            angular.element('.js--default-header-login-form').submit()
          success: ->
            if not $scope.headerLoginInfo.ng_nexturl or $scope.headerLoginInfo.ng_nexturl is ''
              window.location = window.location.href
            else
              window.location = $scope.headerLoginInfo.ng_nexturl
      
      $scope.toggleWelcomeMenu = ->
        if $scope.welcomeMenuOpen
          delete $scope.welcomeMenuOpen
        else
          $scope.welcomeMenuOpen = true
      
      angular.element('body').on 'click', (event) ->
        if $scope.welcomeMenuOpen and angular.element(event.target).closest('.ym-header-welcome').length is 0
          $scope.toggleWelcomeMenu()
        if not $scope.$$phase
          $scope.$apply()
      
      $scope.toggleSiteMenu = ->
        if $scope.siteMenuOpen
          delete $scope.siteMenuOpen
        else
          $scope.siteMenuOpen = true
      
      angular.element('body').on 'click', (event) ->
        if $scope.siteMenuOpen and angular.element(event.target).closest('.ym-site-menu').length is 0
          $scope.toggleSiteMenu()
        if not $scope.$$phase
          $scope.$apply()
      
      $scope.delegatedAddThis = (targetToolboxContainer, shareType) ->
        angular.element(targetToolboxContainer).find('.addthis_button_' + shareType).click()
        false
  ]