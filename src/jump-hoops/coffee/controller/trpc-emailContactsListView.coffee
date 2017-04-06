angular.module 'trPcControllers'
  .controller 'NgPcEmailContactsListViewCtrl', [
    '$rootScope'
    '$scope'
    '$window'
    '$routeParams'
    '$location'
    '$httpParamSerializer'
    '$translate'
    '$uibModal'
    'NgPcTeamraiserEmailService'
    'NgPcContactService'
    ($rootScope, $scope, $window, $routeParams, $location, $httpParamSerializer, $translate, $uibModal, NgPcTeamraiserEmailService, NgPcContactService) ->
      $scope.filter = $routeParams.filter
      
      $scope.emailPromises = []
  ]