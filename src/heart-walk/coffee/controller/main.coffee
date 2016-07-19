angular.module 'ahaLuminateControllers'
  .controller 'MainCtrl', [
    '$scope'
    ($scope) ->
      angular.element('body').on 'click', '.addthis_button_facebook', (e) ->
        e.preventDefault()
  ]