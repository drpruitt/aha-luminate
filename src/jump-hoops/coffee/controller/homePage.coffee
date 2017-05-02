angular.module 'ahaLuminateControllers'
  .controller 'HomeCtrl', [
    '$scope'
    '$timeout'
    'TeamraiserParticipantService'
    '$rootScope'
    '$location'
    '$anchorScroll'
    'ParticipantBadgesService'
    ($scope, $timeout, TeamraiserParticipantService, $rootScope, $location, $anchorScroll, ParticipantBadgesService) ->
      $dataRoot = angular.element '[data-aha-luminate-root]'
      consId = $dataRoot.data('cons-id') if $dataRoot.data('cons-id') isnt ''
      
      if consId
        TeamraiserParticipantService.getRegisteredTeamraisers 'cons_id=' + consId + '&event_type=' + encodeURIComponent('Jump Hoops'),
          error: ->
            modalSet = readCookie 'modalSet'
            if modalSet isnt 'true'
              setModal()
          success: (response) ->
            teamraisers = response.getRegisteredTeamraisersResponse.teamraiser
            numberEvents = 0
            if teamraisers
              teamraisers = [teamraisers] if not angular.isArray teamraisers
              numberEvents = teamraisers.length
            if numberEvents is 0
              modalSet = readCookie 'modalSet'
              if modalSet isnt 'true'
                setModal()
      
      readCookie = (name) ->
        nameEQ = name + '='
        ca = document.cookie.split ';'
        i = 0
        while i < ca.length
          c = ca[i]
          while c.charAt(0) is ' '
            c = c.substring 1, c.length
          if c.indexOf(nameEQ) is 0
            return c.substring nameEQ.length, c.length
          i++
        null
      
      setModal = ->
        date = new Date
        expires = 'expires='
        date.setDate date.getDate() + 1
        expires += date.toGMTString()
        
        angular.element('#noRegModal').modal()
        document.cookie = 'modalSet=true; ' + expires + '; path=/'
      
      $scope.closeModal = ->
        angular.element('#noRegModal').modal 'hide'
        document.getElementById('school-search').scrollIntoView()
      
      $scope.totalStudents = ''
      $scope.totalSchools = ''
      $scope.totalChallenges = ''
      
      ParticipantBadgesService.getRollupTotals()
        .then (response) ->
          if response.data.status is 'success'
            totals = response.data.totals          
            $scope.totalStudents = totals.total_students
            $scope.totalSchools = totals.total_schools
            $scope.totalChallenges = totals.total_challenge_taken_students
          else
            # TODO
      
      console.log $scope.rollUpTotals
      
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
            '<i class="fa fa-chevron-left" aria-hidden="true" />'
            '<i class="fa fa-chevron-right" aria-hidden="true" />'
          ]
      $timeout initCarousel, 1000
      
      initHeroCarousel = ->
        owl = jQuery '.ym-hero__owl-carousel'
        if owl.length
          items = owl.find '> .item'
          if items.length > 1
            owl.owlCarousel
              items: 1
              nav: true
              loop: true
              center: true
              navText: [
                '<i class="fa fa-chevron-left" aria-hidden="true" />'
                '<i class="fa fa-chevron-right" aria-hidden="true" />'
              ]
      $timeout initHeroCarousel, 1000
  ]