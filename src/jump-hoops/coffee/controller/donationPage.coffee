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
        billing_text: angular.element('#billing_info_same_as_donor_row label').text() 

      $scope.donationLevels = []

      DonationService.getDonationFormInfo 'form_id=' + $scope.donationInfo.form_id + '&fr_id=' + $scope.donationInfo.fr_id
        .then (response) ->
          levels = response.data.getDonationFormInfoResponse.donationLevels.donationLevel
          
          angular.forEach levels, (level) ->
            levelId = level.level_id
            amount = level.amount.formatted
            userSpecified = level.userSpecified
            inputId = '#level_standardexpanded'+levelId
            classLevel = 'level'+levelId

            angular.element(inputId).parent().parent().parent().parent().addClass(classLevel)

            levelLabel = angular.element('.'+classLevel).find('.donation-level-expanded-label p').text()

            levelChecked = angular.element('.'+classLevel+' .donation-level-label-input-container input').prop('checked')

            $scope.donationLevels.push
              levelId: levelId
              classLevel: classLevel
              amount: amount
              userSpecified: userSpecified
              levelLabel: levelLabel
              levelChecked: levelChecked


      $scope.giftType = (type) ->
        checkBox = angular.element('.generic-repeat-label-checkbox-container input').prop('checked')

        if type is 'monthly'
          if checkBox == false
            angular.element('.generic-repeat-label-checkbox-container input').click()
          angular.element('.ym-donation-levels__type--onetime').removeClass('btn-toggle--selected')
          angular.element('.ym-donation-levels__type--monthly').addClass('btn-toggle--selected')
        else
          if checkBox == true
            angular.element('.generic-repeat-label-checkbox-container input').click()
          angular.element('.ym-donation-levels__type--onetime').addClass('btn-toggle--selected')
          angular.element('.ym-donation-levels__type--monthly').removeClass('btn-toggle--selected')


      $scope.selectLevel = (type, level, amount) ->
        angular.element('#pstep_finish span').remove()        
        if type is 'level'          
          amt = amount.split('.');
          levelAmt = ' <span>'+amt[0]+' <i class="fa fa-chevron-right" aria-hidden="true"></i></span>'
          console.log levelAmt
          angular.element('#pstep_finish').append(levelAmt)
        else 
          angular.element('#pstep_finish').append('<span></span>')
          

        angular.element('.ym-donation-levels__amounts .btn-toggle.btn-toggle--selected').removeClass('btn-toggle--selected')
        angular.element('.ym-donation-levels__amounts .btn-toggle.level'+level).addClass('btn-toggle--selected')
        angular.element('.ym-donation-levels__message').addClass('hidden')
        angular.element('.ym-donation-levels__message.level'+level).removeClass('hidden')
        angular.element('.donation-level-container.level'+level+' input').click()
        


      $scope.enterAmount = (amount) ->
        angular.element('#pstep_finish span').text('')
        angular.element('#pstep_finish span').prepend('$'+amount)
        angular.element('.donation-level-user-entered input').val(amount)

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