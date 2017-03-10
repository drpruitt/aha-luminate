angular.module 'ahaLuminateControllers'
  .controller 'RegistrationWaiverCtrl', [
    '$scope'
    ($scope) ->
      angular.element('.js--registration-waiver-form').submit()
  ]