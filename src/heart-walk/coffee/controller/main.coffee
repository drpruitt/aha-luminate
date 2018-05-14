angular.module 'ahaLuminateControllers'
  .controller 'MainCtrl', [
    '$scope'
    ($scope) ->
      angular.element('body').on 'click', '.addthis_button_facebook', (e) ->
        e.preventDefault()
      
      angular.element('#ProcessForm .internal-payment span:contains(Swiper)').on 'click', (e) ->
        if not angular.element(e.target).is '#responsive_payment_typepay_typeradiomobilepay'
          angular.element('#responsive_payment_typepay_typeradiomobilepay').click().keypress()
      
      angular.element('#ProcessForm .internal-payment span:contains(Credit)').on 'click', (e) ->
        if not angular.element(e.target).is '#responsive_payment_typepay_typeradiocredit'
          angular.element('#responsive_payment_typepay_typeradiocredit').click().keypress()
      
      angular.element('#ProcessForm .external-payment').on 'click', (e) ->
        if not angular.element(e.target).is '#responsive_payment_typepay_typeradiopaypal'
          angular.element('#responsive_payment_typepay_typeradiopaypal').click().keypress()
  ]
