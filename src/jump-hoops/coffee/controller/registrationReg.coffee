angular.module 'ahaLuminateControllers'
  .controller 'RegistrationRegCtrl', [
    '$scope'
    'TeamraiserRegistrationService'
    ($scope, TeamraiserRegistrationService) ->
      $scope.registrationInfoErrors = 
        errors: []
      $fieldErrors = angular.element '.ErrorMessage'
      angular.forEach $fieldErrors, (fieldError) ->
        $fieldError = angular.element fieldError
        if $fieldError.find('.field-error-text').length > 0
          fieldErrorText = jQuery.trim $fieldError.find('.field-error-text').text()
          fieldErrorText = fieldErrorText.replace(':&nbsp;is a required field', '&nbsp;is a required field').replace(': is a required field', ' is a required field')
          $scope.registrationInfoErrors.errors.push
            text: fieldErrorText
      
      $scope.registrationHiddenFields = 
        fr_cstm_reg: 't'
      $scope.registrationQuestions = {}
      $scope.registrationAdditionalQuestions = {}
      $scope.registrationInfo = {}
      
      $contactInfo = angular.element '.js--registration-reg-contact-info'
      $contactInfoHiddenFields = $contactInfo.find 'input[type="hidden"][name]'
      angular.forEach $contactInfoHiddenFields, (contactInfoHiddenField) ->
        $contactInfoHiddenField = angular.element contactInfoHiddenField
        questionName = $contactInfoHiddenField.attr 'name'
        questionValue = $contactInfoHiddenField.val()
        $scope.registrationHiddenFields[questionName] = questionValue
      $contactInfoQuestions = $contactInfo.find 'input[type="text"], select'
      angular.forEach $contactInfoQuestions, (contactInfoQuestion) ->
        $contactInfoQuestion = angular.element contactInfoQuestion
        questionName = $contactInfoQuestion.attr 'name'
        questionId = $contactInfoQuestion.attr 'id'
        $questionLabel = angular.element 'label[for="' + questionId + '"]'
        questionLabel = undefined
        if $questionLabel.find('.input-label').length > 0
          questionLabel = jQuery.trim $questionLabel.find('.input-label').text()
        questionValue = $contactInfoQuestion.val() or ''
        questionMaxLength = $contactInfoQuestion.attr('maxlength') or ''
        questionHasError = $contactInfoQuestion.is '.form-error *'
        $scope.registrationQuestions[questionName] =
          label: questionLabel
          value: questionValue
          maxLength: questionMaxLength
          hasError: questionHasError
        $scope.registrationInfo[questionName] = questionValue
      
      $optIns = angular.element '.js--registration-reg-opt-ins'
      $optInHiddenFields = $optIns.find 'input[type="hidden"][name]'
      angular.forEach $optInHiddenFields, (optInHiddenField) ->
        $optInHiddenField = angular.element optInHiddenField
        questionName = $optInHiddenField.attr 'name'
        questionValue = $optInHiddenField.val()
        $scope.registrationHiddenFields[questionName] = questionValue
      $optInQuestions = $optIns.find 'input[type="checkbox"]'
      angular.forEach $optInQuestions, (optInQuestion) ->
        $optInQuestion = angular.element optInQuestion
        questionName = $optInQuestion.attr 'name'
        questionId = $optInQuestion.attr 'id'
        $questionLabel = angular.element 'label[for="' + questionId + '"]'
        questionLabel = undefined
        if $questionLabel.find('.input-label').length > 0
          questionLabel = jQuery.trim $questionLabel.find('.input-label').text()
        $scope.registrationQuestions[questionName] =
          label: questionLabel
      
      $loginInfo = angular.element '.js--registration-reg-login-info'
      $loginInfoHiddenFields = $loginInfo.find 'input[type="hidden"][name]'
      angular.forEach $loginInfoHiddenFields, (loginInfoHiddenField) ->
        $loginInfoHiddenField = angular.element loginInfoHiddenField
        questionName = $loginInfoHiddenField.attr 'name'
        questionValue = $loginInfoHiddenField.val()
        $scope.registrationHiddenFields[questionName] = questionValue
      $loginInfoQuestions = $loginInfo.find 'input[type="text"], input[type="password"]'
      angular.forEach $loginInfoQuestions, (loginInfoQuestion) ->
        $loginInfoQuestion = angular.element loginInfoQuestion
        questionName = $loginInfoQuestion.attr 'name'
        questionId = $loginInfoQuestion.attr 'id'
        $questionLabel = angular.element 'label[for="' + questionId + '"]'
        questionLabel = undefined
        if $questionLabel.find('.input-label').length > 0
          questionLabel = jQuery.trim $questionLabel.find('.input-label').text()
        questionValue = $loginInfoQuestion.val() or ''
        questionMaxLength = $loginInfoQuestion.attr('maxlength') or ''
        questionHasError = $loginInfoQuestion.is '.form-error *'
        $scope.registrationQuestions[questionName] =
          label: questionLabel
          value: questionValue
          maxLength: questionMaxLength
          hasError: questionHasError
        $scope.registrationInfo[questionName] = questionValue
      
      $additionalInfo = angular.element '.js--registration-reg-additional-info'
      $additionalInfoHiddenFields = $additionalInfo.find 'input[type="hidden"][name]'
      angular.forEach $additionalInfoHiddenFields, (additionalInfoHiddenField) ->
        $additionalInfoHiddenField = angular.element additionalInfoHiddenField
        questionName = $additionalInfoHiddenField.attr 'name'
        questionValue = $additionalInfoHiddenField.val()
        $scope.registrationHiddenFields[questionName] = questionValue
      $additionalInfoQuestions = $additionalInfo.find 'input[type="text"], input[type="number"], textarea, select'
      angular.forEach $additionalInfoQuestions, (additionalInfoQuestion) ->
        $additionalInfoQuestion = angular.element additionalInfoQuestion
        questionType = $additionalInfoQuestion.prop('tagName').toLowerCase()
        questionName = $additionalInfoQuestion.attr 'name'
        questionId = $additionalInfoQuestion.attr 'id'
        $questionLabel = angular.element 'label[for="' + questionId + '"]'
        questionLegend = undefined
        if $additionalInfoQuestion.is '[class*="survey-date-"] select'
          $questionLegend = $additionalInfoQuestion.closest('fieldset').find 'legend'
          if $questionLegend.find('.input-label').length > 0
            questionLegend = jQuery.trim $questionLegend.find('.input-label').text()
        questionLabel = undefined
        if $questionLabel.find('.input-label').length > 0
          questionLabel = jQuery.trim $questionLabel.find('.input-label').text()
        questionOptions = []
        if questionType is 'select'
          $questionOptions = $additionalInfoQuestion.find 'option'
          angular.forEach $questionOptions, (questionOption) ->
            $questionOption = angular.element questionOption
            questionOptionValue = $questionOption.attr 'value'
            questionOptionText = jQuery.trim $questionOption.text()
            questionOptions.push
              value: questionOptionValue
              text: questionOptionText
        questionValue = $additionalInfoQuestion.val() or ''
        questionMaxLength = $additionalInfoQuestion.attr('maxlength') or ''
        questionHasError = $additionalInfoQuestion.is '.form-error *'
        $scope.registrationQuestions[questionName] =
          type: questionType
          legend: questionLegend
          label: questionLabel
          options: questionOptions
          value: questionValue
          maxLength: questionMaxLength
          hasError: questionHasError
        if questionLegend isnt 'Event Date' and questionLabel isnt 'Additional Challenge Info' and questionLabel isnt 'Number of eCards Sent' and questionLabel isnt 'eCards shared' and questionLabel isnt 'eCards opened' and questionLabel isnt 'eCards clicked'
          $scope.registrationAdditionalQuestions[questionName] = true
        $scope.registrationInfo[questionName] = questionValue
      
      $scope.participationType = {}
      setParticipationType = (participationType) ->
        $scope.participationType = participationType
        if not $scope.$$phase
          $scope.$apply()
      TeamraiserRegistrationService.getParticipationTypes
        error: ->
          # TODO
        success: (response) ->
          participationTypes = response.getParticipationTypesResponse.participationType
          participationTypes = [participationTypes] if not angular.isArray participationTypes
          setParticipationType participationTypes[0]
      $scope.$watch 'participationType.id', (newValue) ->
        if newValue
          TeamraiserRegistrationService.getRegistrationDocument 'participation_id=' + newValue,
            error: ->
              # TODO
            success: (response) ->
              registrationQuestions = response.data.processRegistrationRequest?.primaryRegistration?.question
              if registrationQuestions
                registrationQuestions = [registrationQuestions] if not angular.isArray registrationQuestions
                angular.forEach registrationQuestions, (registrationQuestion) ->
                  registrationQuestionKey = registrationQuestion.key
                  registrationQuestionId = registrationQuestion.id
      
      $scope.previousStep = ->
        $scope.ng_go_back = true
        $timeout ->
          $scope.submitReg()
        , 500
        false
      
      $scope.submitReg = ->
        angular.element('.js--default-reg-form').submit()
        false
  ]