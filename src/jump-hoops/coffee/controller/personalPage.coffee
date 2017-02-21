angular.module 'ahaLuminateControllers'
  .controller 'PersonalPageCtrl', [
    '$scope'
    '$location'
    '$filter'
    '$timeout'
    'TeamraiserParticipantService'
    ($scope, $location, $filter, $timeout, TeamraiserParticipantService) ->
      $scope.participantId = $location.absUrl().split('px=')[1].split('&')[0]

      setParticipantProgress = (amountRaised, goal) ->
        $scope.personalProgress = 
          amountRaised: amountRaised or 0
          goal: goal or 0
        $scope.personalProgress.amountRaisedFormatted = $filter('currency')($scope.personalProgress.amountRaised / 100, '$').replace '.00', ''
        $scope.personalProgress.goalFormatted = $filter('currency')($scope.personalProgress.goal / 100, '$').replace '.00', ''
        if $scope.personalProgress.goal is 0
          $scope.personalProgress.rawPercent = 0
        else
          rawPercent = Math.ceil(($scope.personalProgress.amountRaised / $scope.personalProgress.goal) * 100)
          if rawPercent > 100
            rawPercent = 100
          $scope.personalProgress.rawPercent = rawPercent
        $scope.personalProgress.percent = 0
        if not $scope.$$phase
          $scope.$apply()
        $timeout ->
          percent = $scope.personalProgress.percent
          if $scope.personalProgress.goal isnt 0
            percent = Math.ceil(($scope.personalProgress.amountRaised / $scope.personalProgress.goal) * 100)
          if percent > 100
            percent = 100
          $scope.personalProgress.percent = percent
          if not $scope.$$phase
            $scope.$apply()
        , 500

      TeamraiserParticipantService.getParticipants 'fr_id=' + $scope.frId + '&first_name=' + encodeURIComponent('%%') + '&last_name=' + encodeURIComponent('%') + '&list_filter_column=reg.cons_id&list_filter_text=' + $scope.participantId, 
        error: ->
          setParticipantProgress()
        success: (response) ->
          console.log response
          participantInfo = response.getParticipantsResponse?.participant
          if not participantInfo
            setParticipantProgress()
          else
            setParticipantProgress Number(participantInfo.amountRaised), Number(participantInfo.goal)
  ]