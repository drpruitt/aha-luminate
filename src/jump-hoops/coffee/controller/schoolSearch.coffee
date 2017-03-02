angular.module 'ahaLuminateControllers'
  .controller 'SchoolSearchCtrl', [
    '$scope'
    '$rootScope'
    '$location'
    ($scope, $rootScope, $location) ->
      console.log 'hello'

      name = 'BB'

      TeamraiserCompanyService.getSchools name
        .then (response) ->
          console.log 'get school'
          console.log response

  ]