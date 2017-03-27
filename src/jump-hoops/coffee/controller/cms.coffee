angular.module 'ahaLuminateControllers'
  .controller 'CmsCtrl', [
    '$scope'
    '$timeout'
    ($scope, $timeout) ->
      console.log 'cms ctrl start'
      
      initHomeCarousel = ->
        console.log 'fire rotatorz'
        jQuery('.owl-carousel').owlCarousel
          items: 1
          nav: true
          loop: true
          responsive:
            0: 
              stagePadding: 0
            568:
              stagePadding: 75
            768: 
              stagePadding: 150
            1050:
              stagePadding: 290
      
      $timeout initHomeCarousel, 1000
  ]