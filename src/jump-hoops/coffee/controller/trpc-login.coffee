angular.module 'trPcControllers'
  .controller 'NgPcLoginCtrl', [
    '$rootScope'
    '$scope'
    '$route'
    '$httpParamSerializer'
    'NgPcAuthService'
    ($rootScope, $scope, $route, $httpParamSerializer, NgPcAuthService) ->
      $scope.submitLogin = ->
        if $scope.consLogin.user_name is '' or $scope.consLogin.password is ''
          # TODO
        else
          delete $scope.loginError
          NgPcAuthService.login $httpParamSerializer($scope.consLogin)
            .then (response) ->
              errorResponse = response.data.errorResponse
              if errorResponse
                if ['200', '201', '202', '204'].indexOf(errorResponse.code) isnt -1
                  # TODO
                else
                  $scope.loginError = errorResponse.message
              else
                consId = response.data.loginResponse.cons_id
                if not consId
                  # TODO
                else
                  if Number(consId) isnt Number($rootScope.consId)
                    window.location.reload()
                  else
                    if $rootScope.loginModal
                      $rootScope.loginModal.close()
                      delete $rootScope.loginModal
                    angular.element('.modal').click()
                    $rootScope.consId = consId
                    delete $rootScope.authToken
                    $route.reload()
  ]