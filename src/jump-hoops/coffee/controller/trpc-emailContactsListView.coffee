angular.module 'trPcControllers'
  .controller 'NgPcEmailContactsListViewCtrl', [
    '$rootScope'
    '$scope'
    '$window'
    '$routeParams'
    '$location'
    '$httpParamSerializer'
    '$uibModal'
    'NgPcTeamraiserEmailService'
    'NgPcContactService'
    ($rootScope, $scope, $window, $routeParams, $location, $httpParamSerializer, $uibModal, NgPcTeamraiserEmailService, NgPcContactService) ->
      $scope.filter = $routeParams.filter
      
      $scope.emailPromises = []
  ]