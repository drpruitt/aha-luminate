angular.module 'ahaLuminateControllers'
  .controller 'HomeCtrl', [
    '$scope'
    '$timeout'
    'TeamraiserParticipantService'
    '$rootScope'
    ($scope, $timeout, TeamraiserParticipantService, $rootScope) ->

      $dataRoot = angular.element '[data-aha-luminate-root]'
      consId = $dataRoot.data('cons-id') if $dataRoot.data('cons-id') isnt ''

      if consId != undefined
        TeamraiserParticipantService.getRegisteredTeamraisersCMS '&cons_id='+ consId + '&event_type=Jump%20Hoops'
        .then (response) ->
          console.log 'success'
          console.log response.data
          if response.data.errorResponse
            $rootScope.numberEvents = 0
          else
            $rootScope.numberEvents = response.data.getRegisteredTeamraisersResponse.teamraiser.length
          console.log $rootScope.numberEvents

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