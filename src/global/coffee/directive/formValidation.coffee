angular.module('ahaLuminateApp')
  .directive 'checkZip', ->
    restrict: 'A'
    require: 'ngModel'
    link: (scope, elem, attr, ngModel) ->

      ngModel.$validators.zipcode = (val) ->
        regexp = /^\d{5}(?:[-\s]\d{4})?$/
        if val
          regexp.test val
        else
          true

      return
