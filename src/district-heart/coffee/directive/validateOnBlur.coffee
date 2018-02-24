angular.module('ahaLuminateApp').directive 'noProfanity', ->
  {
    restrict: 'A'
    require: 'ngModel'
    link: (scope, element, attrs, ngModel) ->
      element.bind 'blur', (e) ->

        chkProfanity = (value) ->
          swearwords = [
            'asshole'
            'ass'
            'fucker'
            'fucked'
            'fucking'
            'fuck'
            'bitches'
            'bitching'
            'bitched'
            'bitch'
            'bastard'
            'damn'
            'shitting'
            'shitty'
            'shit'
            'cock'
          ]
          swearwordRegStr = swearwords[0]
          i = 1
          while i < swearwords.length
            if currentValue == swearwords[i]
              return true
            i++
          false

        if !ngModel
          return
        currentValue = element.val()
        ngModel.$setValidity 'profanity', !chkProfanity(currentValue)
        scope.$digest()
      return

  }
