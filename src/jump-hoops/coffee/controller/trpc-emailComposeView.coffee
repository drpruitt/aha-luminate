angular.module 'trPcControllers'
  .controller 'NgPcEmailComposeViewCtrl', [
    '$rootScope'
    '$scope'
    '$routeParams'
    '$timeout'
    '$httpParamSerializer'
    '$uibModal'
    'NgPcTeamraiserEventService'
    'NgPcTeamraiserEmailService'
    'NgPcContactService'
    ($rootScope, $scope, $routeParams, $timeout, $httpParamSerializer, $uibModal, NgPcTeamraiserEventService, NgPcTeamraiserEmailService, NgPcContactService) ->
      $scope.messageType = $routeParams.messageType
      $scope.messageId = $routeParams.messageId
      
      $scope.emailPromises = []
  ]