angular.module 'ahaLuminateControllers'
  .controller 'RegistrationRegCtrl', [
    '$scope'
    'TeamraiserRegistrationService'
    ($scope, TeamraiserRegistrationService) ->
      $scope.registrationHiddenFields = {}
      $scope.registrationQuestions = {}
      
      $contactInfo = angular.element '.js--registration-reg-contact-info'
      $contactInfoHiddenFields = $contactInfo.find 'input[type="hidden"]'
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
        questionLabel = $questionLabel.find('.input-label').text()
        questionMaxLength = $contactInfoQuestion.attr('maxlength') or ''
        $scope.registrationQuestions[questionName] = 
          label: questionLabel
          maxlength: questionMaxLength
      $contactInfo.remove()
      
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
      
      $scope.submitReg = ->
        angular.element('.js--default-reg-form').submit()
        false
  ]