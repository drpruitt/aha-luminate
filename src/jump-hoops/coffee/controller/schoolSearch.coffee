angular.module 'ahaLuminateControllers'
  .controller 'SchoolSearchCtrl', [
    '$scope'
    '$rootScope'
    'TeamraiserCompanyService'
    ($scope, $rootScope, $TeamraiserCompanyService) ->
      console.log 'hello'

      name = 'BB'

      TeamraiserCompanyService.getSchools name
        .then (response) ->
          console.log 'get school'
          console.log response

  ]