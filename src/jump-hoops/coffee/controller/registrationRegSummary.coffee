angular.module 'ahaLuminateControllers'
  .controller 'RegistrationRegSummaryCtrl', [
    '$scope'
    ($scope) ->
      $scope.regSummaryInfo = {}
      
      $participantInfo = angular.element '.js--registration-regsummary-participant-info'
      $scope.regSummaryInfo.cons_first_name = jQuery $participantInfo.find('.contact-info-first').text()
      $scope.regSummaryInfo.cons_last_name = jQuery $participantInfo.find('.contact-info-last').text()
      $scope.regSummaryInfo.cons_email = jQuery $participantInfo.find('.contact-info-email').text()
      
      $scope.submitRegSummary = ->
        angular.element('.js--default-regsummary-form').submit()
        false
  ]