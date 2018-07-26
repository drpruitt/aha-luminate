angular.module 'trPcControllers'
  .controller 'socialViewCtrl', [
    '$rootScope'
    '$scope'
    '$sce'
    '$routeParams'
    '$timeout'
    '$location'
    '$anchorScroll'
    '$httpParamSerializer'
    '$uibModal'
    'APP_INFO'
    'TeamraiserEventService'
    'ConstituentService'
    ($rootScope, $scope, $sce, $routeParams, $timeout, $location, $anchorScroll, $httpParamSerializer, $uibModal, APP_INFO, TeamraiserEventService, ConstituentService) ->

      $scope.socialURL = $sce.trustAsResourceUrl 'https://bfapps1.boundlessfundraising.com/applications/ahahw/social/app/ui/#/addsocial/'+$scope.consId+'/'+$scope.frId+'?source=PCSocial'

  ]
