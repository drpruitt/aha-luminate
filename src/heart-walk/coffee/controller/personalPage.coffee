angular.module 'ahaLuminateControllers'
  .controller 'PersonalPageCtrl', [
    '$scope'
    '$location'
    '$timeout'
    'TeamraiserParticipantService'
    ($scope, $location, $timeout, TeamraiserParticipantService) ->
      $scope.participantId = $location.absUrl().split('px=')[1].split('&')[0]
      
      $scope.participantProgress = {}
      
      setParticipantFundraisingProgress = (amountRaised, goal) ->
        $scope.participantProgress.amountRaised = amountRaised or 0
        $scope.participantProgress.amountRaised = Number $scope.participantProgress.amountRaised
        $scope.participantProgress.goal = goal or 0
        $scope.participantProgress.percent = 2
        $timeout ->
          percent = $scope.participantProgress.percent
          if $scope.participantProgress.goal isnt 0
            percent = Math.ceil(($scope.participantProgress.amountRaised / $scope.participantProgress.goal) * 100)
          if percent < 2
            percent = 2
          if percent > 98
            percent = 98
          $scope.participantProgress.percent = percent
          if not $scope.$$phase
            $scope.$apply()
        , 500
        if not $scope.$$phase
          $scope.$apply()
      TeamraiserParticipantService.getParticipants 'first_name=' + encodeURIComponent('%%%') + '&list_filter_column=reg.cons_id&list_filter_text=' + $scope.participantId, 
        error: ->
          setParticipantFundraisingProgress()
        success: (response) ->
          participantInfo = response.getParticipantsResponse?.participant
          if not participantInfo
            setParticipantFundraisingProgress()
          else
            setParticipantFundraisingProgress participantInfo.amountRaised, participantInfo.goal
  ]