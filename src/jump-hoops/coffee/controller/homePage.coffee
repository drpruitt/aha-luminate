angular.module 'ahaLuminateControllers'
  .controller 'HomeCtrl', [
    '$scope'
    '$timeout'
    'TeamraiserParticipantService'
    ($scope, $timeout, TeamraiserParticipantService) ->
      console.log 'home page'
      regConsId = 3135905
      noRegConsId = 3180158


      TeamraiserParticipantService.getRegisteredTeamraisers 'cons_id='+ regConsId+'event_type=Jump', 
        success: (response) ->
          console.log 'success'
          console.log response
        error: (response) ->
          console.log 'error'
          console.log response

      initCarousel = ->
        owl = jQuery '.ym-home-feature .owl-carousel'
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
          navText: [
            '<i class="fa fa-chevron-left" aria-hidden="true" />',
            '<i class="fa fa-chevron-right" aria-hidden="true" />'
          ]
          
      $timeout initCarousel, 1000


  ]