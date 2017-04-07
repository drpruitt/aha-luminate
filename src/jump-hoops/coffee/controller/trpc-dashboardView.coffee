angular.module 'trPcControllers'
  .controller 'NgPcDashboardViewCtrl', [
    '$rootScope'
    '$scope'
    '$timeout'
    '$filter'
    '$uibModal'
    'NgPcTeamraiserRegistrationService'
    'NgPcTeamraiserProgressService'
    'NgPcTeamraiserTeamService'
    'NgPcTeamraiserCompanyService'
    'NgPcTeamraiserShortcutURLService'
    ($rootScope, $scope, $timeout, $filter, $uibModal, NgPcTeamraiserRegistrationService, NgPcTeamraiserProgressService, NgPcTeamraiserTeamService, NgPcTeamraiserCompanyService, NgPcTeamraiserShortcutURLService) ->
      $scope.dashboardPromises = []
      
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