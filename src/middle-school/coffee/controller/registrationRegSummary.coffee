angular.module 'ahaLuminateControllers'
  .controller 'RegistrationRegSummaryCtrl', [
    '$scope'
    ($scope) ->
      $scope.regSummaryInfo = {}
      
      $participantInfo = angular.element '.js--registration-regsummary-participant-info'
      $scope.regSummaryInfo.cons_first_name = jQuery.trim $participantInfo.find('.contact-info-first').text()
      $scope.regSummaryInfo.cons_last_name = jQuery.trim $participantInfo.find('.contact-info-last').text()
      $scope.regSummaryInfo.cons_email = jQuery.trim $participantInfo.find('.contact-info-email').text()
      $scope.regSummaryInfo.fr_gift = jQuery.trim $participantInfo.find('.additional-gift-amount').text().replace '.00', ''
      
      $scope.submitRegSummary = ->
        angular.element('.js--default-regsummary-form').submit()
        false
  ]