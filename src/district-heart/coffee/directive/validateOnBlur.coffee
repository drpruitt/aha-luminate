
angular.module 'ahaLuminateApp'
  .directive 'validateOnBlur', ->
    restrict: 'A'
    require: 'ngModel'
    scope: {}
    link: (scope, element, attrs, modelCtrl) ->
      element.on 'blur', ->
        modelCtrl.$showValidationMessage = modelCtrl.$dirty
        scope.$apply()
