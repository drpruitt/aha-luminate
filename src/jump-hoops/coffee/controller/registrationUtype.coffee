angular.module 'ahaLuminateControllers'
  .controller 'RegistrationUtypeCtrl', [
    '$scope'
    ($scope) ->
      $scope.toggleUserType = (userType) ->
        $scope.userType = userType
        if userType is 'new'
          angular.element('.js--default-utype-new-form').submit()
          false
      
      $scope.submitUtypeLogin = ->
        angular.element('.js--default-utype-existing-form').submit()
        false
      
      $scope.toggleForgotLogin = (showHide) ->
        $scope.showForgotLogin = showHide is 'show'
      
      $scope.submitForgotLogin = ->
        angular.element('.js--default-utype-send-username-form').submit()
        false
  ]