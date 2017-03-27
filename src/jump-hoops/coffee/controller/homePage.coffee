angular.module 'ahaLuminateControllers'
  .controller 'HomeCtrl', [
    '$scope'
    '$timeout'
    ($scope, $timeout) ->
      initCarousel = ->
        owl =  jQuery('.ym-home-feature .owl-carousel')
        owl.owlCarousel
          items: 1
          nav: true
          loop: true
          center: true
          responsive:
            0: 
              stagePadding: 0
            568:
              stagePadding: 75
            768: 
              stagePadding: 150
            1050:
              stagePadding: 290
        jQuery('.owl-prev').html('<i class="fa fa-chevron-left" aria-hidden="true"></i>')
        jQuery('.owl-next').html('<i class="fa fa-chevron-right" aria-hidden="true"></i>')
                 
      $timeout initCarousel, 1000
  ]