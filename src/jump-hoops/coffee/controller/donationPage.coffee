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
          levels = response.data.getDonationFormInfoResponse.donationLevels.donationLevel
          
          angular.forEach levels, (level) ->
            level_id = level.level_id
            amount = level.amount.formatted
            userSpecified = level.userSpecified
            inputId = '#level_standardexpanded'+level_id
            classLevel = 'level'+level_id

            angular.element(inputId).parent().parent().parent().parent().addClass(classLevel)

            levelLabel = angular.element('.'+classLevel).find('.donation-level-expanded-label p').text()

      employerMatchFields = ->
        angular.element('#employer_name_row').parent().addClass('employer-match')
        angular.element('#employer_street_row').parent().addClass('employer-match')
        angular.element('#employer_city_row').parent().addClass('employer-match')
        angular.element('#employer_state_row').parent().addClass('employer-match')
        angular.element('#employer_zip_row').parent().addClass('employer-match')
        angular.element('#employer_phone_row').parent().addClass('employer-match')
        angular.element('.employer-match').addClass('hidden')

      employerMatchFields()

      $scope.toggleEmployerMatch = ->
        angular.element('.employer-match').toggleClass('hidden')

  ]