angular.module 'ahaLuminateControllers'
  .controller 'RegistrationPaymentCtrl', [
    '$scope'
    ($scope) ->
      $scope.paymentInfoErrors = 
        errors: []
      $fieldErrors = angular.element '.ErrorMessage'
      angular.forEach $fieldErrors, (fieldError) ->
        $fieldError = angular.element fieldError
        if $fieldError.find('.field-error-text').length > 0
          fieldErrorText = jQuery.trim $fieldError.find('.field-error-text').text()
          $scope.registrationInfoErrors.errors.push
            text: fieldErrorText
      
      $scope.paymentHiddenFields = {}
      $scope.paymentQuestions = {}
      $scope.paymentInfo = {}
      
      $billingInfo = angular.element '.js--registration-payment-billing-info'
      $billingInfoHiddenFields = $billingInfo.find 'input[type="hidden"][name]'
      angular.forEach $billingInfoHiddenFields, (billingInfoHiddenField) ->
        $billingInfoHiddenField = angular.element billingInfoHiddenField
        questionName = $billingInfoHiddenField.attr 'name'
        questionValue = $billingInfoHiddenField.val()
        $scope.paymentHiddenFields[questionName] = questionValue
      $billingInfoQuestions = $billingInfo.find 'input[type="text"], select'
      angular.forEach $billingInfoQuestions, (billingInfoQuestion) ->
        $billingInfoQuestion = angular.element billingInfoQuestion
        questionType = $billingInfoQuestion.prop('tagName').toLowerCase()
        questionName = $billingInfoQuestion.attr 'name'
        questionId = $billingInfoQuestion.attr 'id'
        questionOptions = []
        if questionType is 'select'
          $questionOptions = $billingInfoQuestion.find 'option'
          angular.forEach $questionOptions, (questionOption) ->
            $questionOption = angular.element questionOption
            questionOptionValue = $questionOption.attr 'value'
            questionOptionText = jQuery.trim $questionOption.text()
            questionOptions.push
              value: questionOptionValue
              text: questionOptionText
        questionValue = $billingInfoQuestion.val() or ''
        questionMaxLength = $billingInfoQuestion.attr('maxlength') or ''
        questionHasError = $billingInfoQuestion.is '.form-error *'
        $scope.paymentQuestions[questionName] =
          type: questionType
          options: questionOptions
          value: questionValue
          maxLength: questionMaxLength
          hasError: questionHasError
        $scope.paymentInfo[questionName] = questionValue
      
      $accountInfo = angular.element '.js--registration-payment-account-info'
      $accountInfoHiddenFields = $accountInfo.find 'input[type="hidden"][name]'
      angular.forEach $accountInfoHiddenFields, (accountInfoHiddenField) ->
        $accountInfoHiddenField = angular.element accountInfoHiddenField
        questionName = $accountInfoHiddenField.attr 'name'
        questionValue = $accountInfoHiddenField.val()
        $scope.paymentHiddenFields[questionName] = questionValue
      $accountInfoQuestions = $accountInfo.find 'input[type="text"], select'
      angular.forEach $accountInfoQuestions, (accountInfoQuestion) ->
        $accountInfoQuestion = angular.element accountInfoQuestion
        questionType = $accountInfoQuestion.prop('tagName').toLowerCase()
        questionName = $accountInfoQuestion.attr 'name'
        questionId = $accountInfoQuestion.attr 'id'
        questionOptions = []
        if questionType is 'select'
          $questionOptions = $accountInfoQuestion.find 'option'
          angular.forEach $questionOptions, (questionOption) ->
            $questionOption = angular.element questionOption
            questionOptionValue = $questionOption.attr 'value'
            questionOptionText = jQuery.trim $questionOption.text()
            questionOptions.push
              value: questionOptionValue
              text: questionOptionText
        questionValue = $accountInfoQuestion.val() or ''
        questionMaxLength = $accountInfoQuestion.attr('maxlength') or ''
        questionHasError = $accountInfoQuestion.is '.form-error *'
        $scope.paymentQuestions[questionName] =
          type: questionType
          options: questionOptions
          value: questionValue
          maxLength: questionMaxLength
          hasError: questionHasError
        $scope.paymentInfo[questionName] = questionValue
      
      $scope.submitPayment = ->
        angular.element('.js--default-payment-form').submit()
        false
  ]