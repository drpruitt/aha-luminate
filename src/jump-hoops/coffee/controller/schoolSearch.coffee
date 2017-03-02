angular.module 'ahaLuminateControllers'
  .controller 'SchoolSearchCtrl', [
    '$scope'
    '$rootScope'
    'TeamraiserCompanyService'
    ($scope, $rootScope, TeamraiserCompanyService) ->
  

      name = 'Black'
      console.log name

      TeamraiserCompanyService.getSchools name
        .then (response) ->
          console.log 'get school'
          console.log response

  ]