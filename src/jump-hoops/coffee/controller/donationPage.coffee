angular.module 'ahaLuminateControllers'
  .controller 'DonationCtrl', [
    '$scope'
    '$rootScope'
    'DonationService'
    ($scope, $rootScope, DonationService) ->
      $donationFormRoot = angular.element '[data-donation-form-root]'

      console.log 'tesdt'

      $scope.donationInfo = 
        validate: 'true'
        form_id: $donationFormRoot.data 'formid'
        fr_id: $donationFormRoot.data 'frid'
        billing_text: angular.element('#billing_info_same_as_donor_row label').text() 

      DonationService.getDonationFormInfo 'form_id=' + $scope.donationInfo.form_id + '&fr_id=' + $scope.donationInfo.fr_id
        .then (response) ->
          console.log response
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

      billingAddressFields = ->
        angular.element('#billing_first_name_row').addClass('billing-info')
        angular.element('#billing_last_name_row').addClass('billing-info')
        angular.element('#billing_addr_street1_row').addClass('billing-info')
        angular.element('#billing_addr_street2_row').addClass('billing-info')
        angular.element('#billing_addr_city_row').addClass('billing-info')
        angular.element('#billing_addr_state_row').addClass('billing-info')
        angular.element('#billing_addr_zip_row').addClass('billing-info')
        angular.element('#billing_addr_country_row').addClass('billing-info')
        angular.element('.billing-info').addClass('hidden')

      billingAddressFields()

      $scope.toggleBillingInfo = ->
        angular.element('.billing-info').toggleClass('hidden');
        inputStatus = angular.element('#billing_info').prop('checked')

        if inputStatus == true
          angular.element('#billing_info_same_as_donorname').prop('checked', 'true')
        else
          angular.element('#billing_info_same_as_donorname').prop('checked', 'false')
  ]