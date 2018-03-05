angular.module('ahaLuminateApp')
  .directive 'checkZip', ->
    restrict: 'A'
    require: 'ngModel'
    scope: false
    link: (scope, element, attrs, ngModel) ->
      element.bind 'blur', (e) ->
        ngModel.$validators.zipcode = (val) ->
          regexp = /^\d{5}(?:[-\s]\d{4})?$/
          if val
            currentval = regexp.test val
            ngModel.$setValidity 'checkzip', currentValue
            scope.$digest()
          else
            true

     return
