angular.module('ahaLuminateApp')
  .directive 'checkZip', ->
    restrict: 'A'
    require: 'ngModel'
    scope: false
    link: (scope, element, attrs, ngModel) ->
      element.bind 'blur', (e) ->
        padZip = (width, string, padding) ->
          if width <= string.length then string else padZip(width, padding + string, padding)
        validateZipcode = (val) ->
          regexp = /^\d{5}(?:[-\s]\d{4})?$/
          if val
            regexp.test val
          else
            true
        
        element.val(padZip(5,element.val(),"0"))
        currentValue = element.val()
        ngModel.$setValidity 'checkzip', validateZipcode(currentValue)
        scope.$digest()
      return
