angular.module 'trPcControllers'
  .controller 'NgPcDashboardViewCtrl', [
    '$rootScope'
    '$scope'
    '$timeout'
    '$filter'
    '$uibModal'
    'ZuriService'
    'NgPcTeamraiserRegistrationService'
    'NgPcTeamraiserProgressService'
    'NgPcTeamraiserTeamService'
    'NgPcTeamraiserCompanyService'
    'NgPcTeamraiserShortcutURLService'
    ($rootScope, $scope, $timeout, $filter, $uibModal, ZuriService, NgPcTeamraiserRegistrationService, NgPcTeamraiserProgressService, NgPcTeamraiserTeamService, NgPcTeamraiserCompanyService, NgPcTeamraiserShortcutURLService) ->
      $scope.dashboardPromises = []
      
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