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
      
      $scope.toggleForgotUsername = (showHide) ->
        $scope.showForgotUsername = showHide is 'show'
      
      $scope.submitForgotUsername = ->
        angular.element('.js--default-utype-send-username-form').submit()
        false
  ]