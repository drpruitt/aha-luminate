angular.module('ahaLuminateApp')
  .directive 'noProfanity', ->
    restrict: 'A'
    require: 'ngModel'
    scope: false
    link: (scope, element, attrs, ngModel) ->
      element.bind 'blur', (e) ->
        chkProfanity = (value) ->
          swearwordRegStr = scope.swearwords[0]
          i = 1
          while i < scope.swearwords.length
            if currentValue.toLowerCase() == scope.swearwords[i]
              return true
            i++
          false

        if !ngModel
          return
        currentValue = element.val()
        ngModel.$setValidity 'profanity', !chkProfanity(currentValue)
        scope.$digest()
      return
