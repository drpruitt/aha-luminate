angular.module 'trPcControllers'
  .controller 'NgPcDashboardViewCtrl', [
    '$rootScope'
    '$scope'
    '$timeout'
    '$filter'
    '$translate'
    '$uibModal'
    'TeamraiserRegistrationService'
    'TeamraiserProgressService'
    'TeamraiserTeamService'
    'TeamraiserCompanyService'
    'TeamraiserShortcutURLService'
    ($rootScope, $scope, $timeout, $filter, $translate, $uibModal, TeamraiserRegistrationService, TeamraiserProgressService, TeamraiserTeamService, TeamraiserCompanyService, TeamraiserShortcutURLService) ->
      $scope.dashboardPromises = []
  ]