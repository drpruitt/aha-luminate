angular.module 'trPcControllers'
  .controller 'NgPcEmailMessageListViewCtrl', [
    '$scope'
    '$routeParams'
    '$location'
    '$uibModal'
    'NgPcTeamraiserEmailService'
    'NgPcContactService'
    ($scope, $routeParams, $location, $uibModal, NgPcTeamraiserEmailService, NgPcContactService) ->
      $scope.messageType = $routeParams.messageType
      
      $scope.emailPromises = []
  ]