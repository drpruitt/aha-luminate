angular.module 'ahaLuminateControllers'
  .controller 'DonationCtrl', [
    '$scope'
    '$rootScope'
    '$location'
    'DonationService'
    'ZuriService'
    ($scope, $rootScope, $location, DonationService, ZuriService) ->
      ecardLinkParam = $location.absUrl().split('ecard_linktrack=')[1]
      if ecardLinkParam != undefined
        ecardLinkParamSplit = ecardLinkParam.split('&')[0]
        ZuriService.eCardTracking ecardLinkParamSplit,
      
      $scope.paymentInfoErrors = 
        errors: []
      angular.element('.page-error').remove()
      $fieldErrors = angular.element '.ErrorMessage'
      angular.forEach $fieldErrors, (fieldError) ->
        $fieldError = angular.element fieldError
        if $fieldError.find('.field-error-text').length > 0
          fieldErrorText = jQuery.trim $fieldError.find('.field-error-text').text()
          $scope.paymentInfoErrors.errors.push
            text: fieldErrorText
      
      $errorContainer = angular.element '.form-error'
      angular.forEach $errorContainer, (error) ->
        $error = angular.element error
        angular.element($error).addClass 'has-error'
        angular.element($error).removeClass 'form-error'
      
      $scope.donationInfo = 
        validate: 'true'
        form_id: angular.element('#df_id').val()
        fr_id: angular.element('#FR_ID').val()
        billing_text: angular.element('#billing_info_same_as_donor_row label').text()
        giftType: 'onetime'
      
      $scope.donationLevels = []
      
      $scope.giftType = (type) ->  
        $scope.donationInfo.giftType = type    
        if type is 'monthly'
          angular.element('.ym-donation-levels__type--onetime').removeClass 'active'
          angular.element('.ym-donation-levels__type--monthly').addClass 'active'
          angular.element('#level_installment_row').removeClass 'hidden'

        else
          angular.element('.ym-donation-levels__type--onetime').addClass 'active'
          angular.element('.ym-donation-levels__type--monthly').removeClass 'active'
          angular.element('#level_installment_row').addClass 'hidden'
          angular.element('#level_installmentduration').val 'S:0'
      
      $scope.selectLevel = (type, level, amount) ->
        angular.element('#pstep_finish span').remove()
        if type is 'level'
          levelAmt = ' <span>' + amount + ' <i class="fa fa-chevron-right" aria-hidden="true"></i></span>'
          angular.element('#pstep_finish').append levelAmt
        else
          angular.element('#pstep_finish').append '<span />'
        
        angular.element('.ym-donation-levels__amount .btn-toggle.active').removeClass 'active'
        angular.element('.ym-donation-levels__amount .btn-toggle.level' + level).addClass 'active'
        angular.element('.ym-donation-levels__message').addClass 'hidden'
        angular.element('.ym-donation-levels__message.level' + level).removeClass 'hidden'
        angular.element('.donation-level-container.level' + level + ' input').click()
      
      $scope.enterAmount = (amount) ->
        angular.element('#pstep_finish span').text ''
        angular.element('#pstep_finish span').prepend('$' + amount)
        angular.element('.donation-level-user-entered input').val amount
      
      employerMatchFields = ->
        angular.element('#employer_name_row').parent().addClass 'ym-employer-match__fields'
        angular.element('#employer_street_row').parent().addClass 'ym-employer-match__fields'
        angular.element('#employer_city_row').parent().addClass 'ym-employer-match__fields'
        angular.element('#employer_state_row').parent().addClass 'ym-employer-match__fields'
        angular.element('#employer_zip_row').parent().addClass 'ym-employer-match__fields'
        angular.element('#employer_phone_row').parent().addClass 'ym-employer-match__fields'
        angular.element('.employer-address-container').addClass 'hidden'
      
      $scope.toggleEmployerMatch = ->
        angular.element('.ym-employer-match__message').toggleClass 'hidden'
        angular.element('.employer-address-container').toggleClass 'hidden'
      
      donorRecognitionFields = ->
        angular.element('#tr_show_gift_to_public_row').addClass 'hidden ym-donor-recognition__fields'
        angular.element('#tr_recognition_nameanonymous_row').addClass 'hidden ym-donor-recognition__fields'
        angular.element('#tr_recognition_namerec_name_row').addClass 'hidden ym-donor-recognition__fields'
      
      $scope.toggleDonorRecognition = ->
        angular.element('.ym-donor-recognition__fields').toggleClass 'hidden'
      
      $scope.togglePersonalNote = ->
        angular.element('#tr_message_to_participant_row').toggleClass 'hidden ym-border'
      
      $scope.tributeGift = (type) ->
        if type is 'honor'
          angular.element('.btn-toggle--honor').toggleClass 'active'
          
          if angular.element('.btn-toggle--honor').is '.active'
            angular.element('.btn-toggle--memory').removeClass 'active'
            angular.element('#tribute_type').val 'tribute_type_value2'
            angular.element('#tribute_show_honor_fieldsname').prop 'checked', true
            angular.element('#tribute_honoree_name_row').show()
          else
            angular.element('#tribute_type').val ''
            angular.element('#tribute_show_honor_fieldsname').prop 'checked', false
            angular.element('#tribute_honoree_name_row').hide()
        else
          angular.element('.btn-toggle--memory').toggleClass 'active'
          
          if angular.element('.btn-toggle--memory').is '.active'
            angular.element('.btn-toggle--honor').removeClass 'active'
            angular.element('#tribute_type').val 'tribute_type_value1'
            angular.element('#tribute_show_honor_fieldsname').prop 'checked', true
            angular.element('#tribute_honoree_name_row').show()
          else
            angular.element('#tribute_type').val ''
            angular.element('#tribute_show_honor_fieldsname').prop 'checked', false
            angular.element('#tribute_honoree_name_row').hide()
      
      billingAddressFields = ->
        angular.element('#billing_first_name_row').addClass 'billing-info'
        angular.element('#billing_last_name_row').addClass 'billing-info'
        angular.element('#billing_addr_street1_row').addClass 'billing-info'
        angular.element('#billing_addr_street2_row').addClass 'billing-info'
        angular.element('#billing_addr_city_row').addClass 'billing-info'
        angular.element('#billing_addr_state_row').addClass 'billing-info'
        angular.element('#billing_addr_zip_row').addClass 'billing-info'
        angular.element('#billing_addr_country_row').addClass 'billing-info'
        angular.element('.billing-info').addClass 'hidden'
      
      $scope.toggleBillingInfo = ->
        angular.element('.billing-info').toggleClass 'hidden'
        inputStatus = angular.element('#billing_info').prop 'checked'
        
        if inputStatus is true
          angular.element('#billing_info_same_as_donorname').prop 'checked', true
        else
          angular.element('#billing_info_same_as_donorname').prop 'checked', false
      
      loadForm = ->
        DonationService.getDonationFormInfo 'form_id=' + $scope.donationInfo.form_id + '&fr_id=' + $scope.donationInfo.fr_id
          .then (response) ->
            levels = response.data.getDonationFormInfoResponse.donationLevels.donationLevel
            
            angular.forEach levels, (level) ->
              levelId = level.level_id
              amount = level.amount.formatted
              amount = amount.split('.')[0]
              userSpecified = level.userSpecified
              inputId = '#level_installmentexpanded' + levelId
              classLevel = 'level' + levelId
              
              angular.element(inputId).parent().parent().parent().parent().addClass classLevel
              
              levelLabel = angular.element('.' + classLevel).find('.donation-level-expanded-label p').text()
              
              levelChecked = angular.element('.' + classLevel + ' .donation-level-label-input-container input').prop 'checked'
              
              $scope.donationLevels.push
                levelId: levelId
                classLevel: classLevel
                amount: amount
                userSpecified: userSpecified
                levelLabel: levelLabel
                levelChecked: levelChecked
        
        optional = '<span class="ym-optional">Optional</span>'       
        angular.element('#donor_phone_row label').append optional
        angular.element('#tr_message_to_participant_row').addClass 'hidden'
        angular.element('#billing_info').parent().addClass 'billing_info_toggle'
        angular.element('#payment_cc_container').append '<div class="clearfix" />'
        angular.element('#responsive_payment_typecc_cvv_row .FormLabelText').text 'CVV:'
        angular.element('#level_installment_row').addClass 'hidden'
        angular.element('.employer-address-container').addClass 'clearfix'

        angular.element('#tr_recognition_namerec_namename').attr('placeholder', 'If different from your name')
        angular.element('#tr_message_to_participantname').attr('placeholder', 'Write a message of encouragement. 255 characters max.')

        employerMatchFields()
        billingAddressFields()
        donorRecognitionFields()
      loadForm()
  ]