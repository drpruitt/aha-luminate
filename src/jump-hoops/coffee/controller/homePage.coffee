angular.module 'ahaLuminateControllers'
  .controller 'HomeCtrl', [
    '$scope'
    '$timeout'
    'TeamraiserParticipantService'
    '$rootScope'
    '$location'
    '$anchorScroll'
    ($scope, $timeout, TeamraiserParticipantService, $rootScope, $location, $anchorScroll) ->
      $dataRoot = angular.element '[data-aha-luminate-root]'
      consId = $dataRoot.data('cons-id') if $dataRoot.data('cons-id') isnt ''

      if consId
        TeamraiserParticipantService.getRegisteredTeamraisersCMS '&cons_id='+ consId + '&event_type=Jump%20Hoops'
        .then (response) ->
          if response.data.errorResponse
            modalSet = readCookie 'modalSet'
            if modalSet != 'true'
              setModal()

      readCookie = (name) ->
        nameEQ = name + '='
        ca = document.cookie.split(';')
        i = 0
        while i < ca.length
          c = ca[i]
          while c.charAt(0) == ' '
            c = c.substring(1, c.length)
          if c.indexOf(nameEQ) == 0
            return c.substring(nameEQ.length, c.length)
          i++
        null 

      setModal = ->
        date = new Date
        expires = 'expires='
        date.setDate date.getDate() + 1
        expires += date.toGMTString()

        angular.element('#noRegModal').modal() 
        document.cookie = 'modalSet=true ; ' + expires + '; path=/'

      $scope.closeModal = ->
        angular.element('#noRegModal').modal('hide')
        document.getElementById('school-search').scrollIntoView()
        

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