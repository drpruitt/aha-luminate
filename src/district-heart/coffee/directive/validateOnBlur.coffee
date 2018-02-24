
angular.module 'ahaLuminateApp'
  .directive 'validateOnBlur', [ 
    'APP_INFO'
    (APP_INFO) ->
      ddo = 
        restrict: 'A'
        require: 'ngModel'
        scope: {}
        link: (scope, element, attrs, modelCtrl) ->
          element.on 'blur', ->
            modelCtrl.$showValidationMessage = true #modelCtrl.$dirty
            scope.$apply()
            return
          return
      ddo
]
