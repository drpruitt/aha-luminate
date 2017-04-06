angular.module 'trPcControllers'
  .controller 'NgPcEmailMessageListViewCtrl', [
    '$scope'
    '$routeParams'
    '$location'
    '$translate'
    '$uibModal'
    'NgPcTeamraiserEmailService'
    'NgPcContactService'
    ($scope, $routeParams, $location, $translate, $uibModal, NgPcTeamraiserEmailService, NgPcContactService) ->
      $scope.messageType = $routeParams.messageType
      
      $scope.emailPromises = []
  ]