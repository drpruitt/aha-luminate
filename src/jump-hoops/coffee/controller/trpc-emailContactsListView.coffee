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
    'TeamraiserEmailService'
    'ContactService'
    ($rootScope, $scope, $window, $routeParams, $location, $httpParamSerializer, $translate, $uibModal, TeamraiserEmailService, ContactService) ->
      $scope.filter = $routeParams.filter
      
      $scope.emailPromises = []
  ]