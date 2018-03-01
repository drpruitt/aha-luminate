angular.module 'ahaLuminateControllers'
  .controller 'MainCtrl', [
    '$scope'
    'profanityService'
    ($scope, profanityService) ->
      angular.element('body').on 'click', '.addthis_button_facebook', (e) ->
        e.preventDefault()
      
      angular.element('#ProcessForm .internal-payment').on 'click', (e) ->
        if not angular.element(e.target).is '#responsive_payment_typepay_typeradiocredit'
          angular.element('#responsive_payment_typepay_typeradiocredit').click().keypress()
      
      angular.element('#ProcessForm .external-payment').on 'click', (e) ->
        if not angular.element(e.target).is '#responsive_payment_typepay_typeradiopaypal'
          angular.element('#responsive_payment_typepay_typeradiopaypal').click().keypress()
      
      #add default reg fields mainly for modeling and the profanity filter
      $scope.registrationInfo = []
      $scope.registrationInfo.cons_first_name = ""
      $scope.registrationInfo.cons_last_name = ""

      profanityService.loadProfanityList().then (data) ->
        $scope.swearwords = data
        return
      
      $scope.registrationInfoErrors = 
        errors: []
      
      $scope.submitRegForm = (e) ->
        if  $scope.F2fRegContact.$valid
            angular.element('.js--default-reg-form').submit()
        else
          $scope.registrationInfoErrors.errors = [
            {
              text: 'Please correct the errors below and try again.'
            }
          ]
          window.scrollTo 0, 0
          e.preventDefault();
        false
  ]
