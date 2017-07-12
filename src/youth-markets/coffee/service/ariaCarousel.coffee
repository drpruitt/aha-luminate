angular.module 'ahaLuminateApp'
  .factory 'AriaCarouselService', [ 
    '$timeout'
    ($timeout)  ->
      init: (elem)->
        angular.element(elem).find('.owl-item').attr 'aria-selected', 'false'
        angular.element(elem).find('.owl-item').attr 'role', 'listitem'
        angular.element(elem).find('owl-item, .owl-item a').attr 'tabindex', '-1'
        angular.element(elem).find('.owl-item.active').attr 'aria-selected', 'true'
        angular.element(elem).find('.owl-prev').attr('role', 'button').attr 'title', 'Previous'
        angular.element(elem).find('.owl-next').attr('role', 'button').attr 'title', 'Next'
        angular.element(elem).find('.owl-item.active, .owl-item.active a, .owl-prev, .owl-next').attr 'tabindex', '0'
        jQuery(document).on 'keydown', (e) ->
          $focusedElement = jQuery(document.activeElement)
          if e.which is 13
            if $focusedElement.is '.owl-next'
              jQuery(elem).trigger 'next.owl.carousel'
            if $focusedElement.is '.owl-prev'
              jQuery(elem).trigger 'prev.owl.carousel'
        return
      
      onChange: (elem) ->
        changeCarousel = ->
          angular.element(elem).find('.owl-item').attr 'aria-selected', 'false'
          angular.element(elem).find('.owl-item, .owl-item a').attr 'tabindex', '-1' 
          angular.element(elem).find('.owl-item.active').attr 'aria-selected', 'true'
          angular.element(elem).find('.owl-item.active, .owl-item.active a').attr 'tabindex', '0' 
        $timeout changeCarousel, 500
  ]