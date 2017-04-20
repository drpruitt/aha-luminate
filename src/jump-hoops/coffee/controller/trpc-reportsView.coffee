angular.module 'trPcControllers'
  .controller 'NgPcReportsViewCtrl', [
    '$scope'
    ($scope) ->
      $scope.reportPromises = []
      
      $scope.activeReportTab = if $scope.participantRegistration.companyInformation.isCompanyCoordinator is 'true' then 0 else 1
  ]