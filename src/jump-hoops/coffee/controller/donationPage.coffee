angular.module 'ahaLuminateControllers'
  .controller 'DonationCtrl', [
    '$scope'
    '$rootScope'
    'DonationService'
    ($scope, $rootScope, DonationService) ->
      $donationFormRoot = angular.element '[data-donation-form-root]'

      $scope.donationInfo = 
        validate: 'true'
        form_id: $donationFormRoot.data 'formid'
        fr_id: $donationFormRoot.data 'frid'

      DonationService.getDonationFormInfo 'form_id=' + $scope.donationInfo.form_id + '&fr_id=' + $scope.donationInfo.fr_id
        .then (response) ->
          console.log response

  ]