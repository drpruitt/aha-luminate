angular.module 'ahaLuminateControllers'
  .controller 'RegistrationPtypeCtrl', [
    '$scope'
    ($scope) ->
      if not $scope.participationOptions
        $scope.participationOptions = {}
      
      $participationType = angular.element('.js--registration-ptype-part-types input[name="fr_part_radio"]').eq 0
      $scope.participationOptions.fr_part_radio = $participationType.val()
      
      $scope.submitPtype = ->
        angular.element('.js--default-ptype-form').submit()
        false
  ]