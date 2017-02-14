angular.module 'ahaLuminateControllers'
  .controller 'CompanyPageCtrl', [
    '$scope'
    '$location'
    ($scope, $location) ->
      $scope.companyId = $location.absUrl().split('company_id=')[1].split('&')[0]
  ]