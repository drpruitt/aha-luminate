angular.module 'trPcControllers'
  .controller 'NgPcEmailComposeViewCtrl', [
    '$rootScope'
    '$scope'
    '$routeParams'
    '$timeout'
    '$httpParamSerializer'
    '$uibModal'
    'TeamraiserEventService'
    'TeamraiserEmailService'
    'ContactService'
    ($rootScope, $scope, $routeParams, $timeout, $httpParamSerializer, $uibModal, TeamraiserEventService, TeamraiserEmailService, ContactService) ->
      $scope.messageType = $routeParams.messageType
      $scope.messageId = $routeParams.messageId
      
      $scope.emailPromises = []
  ]