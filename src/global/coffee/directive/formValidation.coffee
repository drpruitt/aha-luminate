angular.module('ahaLuminateApp')
  .directive 'checkZip', ->
    restrict: 'A'
    require: 'ngModel'
    scope: false
    link: (scope, element, attrs, ngModel) ->
      element.bind 'blur', (e) ->
        validateZipcode = (val) ->
          regexp = /^\d{5}(?:[-\s]\d{4})?$/
          if val
            regexp.test val
          else
            true

        currentValue = element.val();
        ngModel.$setValidity 'checkzip', validateZipcode(currentValue)
        scope.$digest()
      return
