angular.module 'trPcControllers'
  .controller 'NgPcEmailMessageListViewCtrl', [
    '$scope'
    '$routeParams'
    '$location'
    '$translate'
    '$uibModal'
    'TeamraiserEmailService'
    'ContactService'
    ($scope, $routeParams, $location, $translate, $uibModal, TeamraiserEmailService, ContactService) ->
      $scope.messageType = $routeParams.messageType
      
      $scope.emailPromises = []
  ]