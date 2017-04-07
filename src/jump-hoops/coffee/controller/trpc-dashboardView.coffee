angular.module 'trPcControllers'
  .controller 'NgPcDashboardViewCtrl', [
    '$rootScope'
    '$scope'
    '$filter'
    '$uibModal'
    'ZuriService'
    'NgPcTeamraiserRegistrationService'
    'NgPcTeamraiserProgressService'
    'NgPcTeamraiserTeamService'
    'NgPcTeamraiserCompanyService'
    'NgPcTeamraiserShortcutURLService'
    ($rootScope, $scope, $filter, $uibModal, ZuriService, NgPcTeamraiserRegistrationService, NgPcTeamraiserProgressService, NgPcTeamraiserTeamService, NgPcTeamraiserCompanyService, NgPcTeamraiserShortcutURLService) ->
      $scope.dashboardPromises = []
      
      fundraisingProgressPromise = TeamraiserProgressService.getProgress()
        .then (response) ->
          participantProgress = response.data.getParticipantProgressResponse?.personalProgress
          if participantProgress
            participantProgress.raised = Number participantProgress.raised
            participantProgress.raisedFormatted = if participantProgress.raised then $filter('currency')(participantProgress.raised / 100, '$', 0) else '$0'
            participantProgress.goal = Number participantProgress.goal
            participantProgress.goalFormatted = if participantProgress.goal then $filter('currency')(participantProgress.goal / 100, '$', 0) else '$0'
            participantProgress.percent = 0
            if participantProgress.goal isnt 0
              participantProgress.percent = Math.ceil((participantProgress.raised / $scope.participantProgress.goal) * 100)
            if participantProgress.percent > 100
              participantProgress.percent = 100
            $scope.participantProgress = participantProgress
          if $scope.participantRegistration.teamId and $scope.participantRegistration.teamId isnt '-1'
            teamProgress = response.data.getParticipantProgressResponse?.teamProgress
            if teamProgress
              teamProgress.raised = Number teamProgress.raised
              teamProgress.raisedFormatted = if teamProgress.raised then $filter('currency')(teamProgress.raised / 100, '$', 0) else '$0'
              teamProgress.goal = Number teamProgress.goal
              teamProgress.goalFormatted = if teamProgress.goal then $filter('currency')(teamProgress.goal / 100, '$', 0) else '$0'
              teamProgress.percent = 0
              if teamProgress.goal isnt 0
                teamProgress.percent = Math.ceil((teamProgress.raised / teamProgress.goal) * 100)
              if teamProgress.percent > 100
                teamProgress.percent = 100
              $scope.teamProgress = teamProgress
          if $scope.participantRegistration.companyInformation and $scope.participantRegistration.companyInformation.companyId and $scope.participantRegistration.companyInformation.companyId isnt -1
            companyProgress = response.data.getParticipantProgressResponse?.companyProgress
            if companyProgress
              companyProgress.raised = Number companyProgress.raised
              companyProgress.raisedFormatted = if companyProgress.raised then $filter('currency')(companyProgress.raised / 100, '$', 0) else '$0'
              companyProgress.goal = Number companyProgress.goal
              companyProgress.goalFormatted = if companyProgress.goal then $filter('currency')(companyProgress.goal / 100, '$', 0) else '$0'
              companyProgress.percent = 0
              if companyProgress.goal isnt 0
                companyProgress.percent = Math.ceil((companyProgress.raised / companyProgress.goal) * 100)
              if companyProgress.percent > 100
                companyProgress.percent = 100
              $scope.companyProgress = companyProgress
          response
      $scope.dashboardPromises.push fundraisingProgressPromise
      
      $scope.personalChallenge = {}
      ZuriService.getZooStudent $scope.frId + '/' + $scope.consId, 
        error: ->
          # TODO
        success: (response) ->
          personalChallenges = response.data.challenges
          if personalChallenges
            $scope.personalChallenge.id = personalChallenges.current
            $scope.personalChallenge.name = personalChallenges.text
            $scope.personalChallenge.completed = personalChallenges.completed
      
      if $scope.participantRegistration.teamId and $scope.participantRegistration.teamId isnt '-1'
        captainsMessagePromise = NgPcTeamraiserTeamService.getCaptainsMessage()
          .then (response) ->
            teamCaptainsMessage = response.data.getCaptainsMessageResponse
            if teamCaptainsMessage
              $scope.teamCaptainsMessage = teamCaptainsMessage
              if not angular.isString $scope.teamCaptainsMessage.message
                delete $scope.teamCaptainsMessage.message
            response
        $scope.dashboardPromises.push captainsMessagePromise
  ]