angular.module 'ahaLuminateApp'
  .directive 'eqColumnHeight', [
    '$window'
    '$timeout'
    ($window, $timeout) ->
      restrict: 'A'
      link: (scope, element) ->
        resizeColumns = ->
          angular.element(element).css 'height', ''
          angular.element(element).siblings('[eq-column-height]').css 'height', ''
          columnHeight = Number angular.element(element).css('height').replace('px', '')
          angular.element(element).siblings('[eq-column-height]').each () ->
            siblingHeight = Number angular.element(this).css('height').replace('px', '')
            if siblingHeight > columnHeight
              columnHeight = siblingHeight
          angular.element(element).css 'height', columnHeight + 'px'
          angular.element(element).siblings('[eq-column-height]').css 'height', columnHeight + 'px'
        $timeout resizeColumns, 500
        angular.element($window).bind 'resize', ->
          resizeColumns()
          scope.$digest()
  ]