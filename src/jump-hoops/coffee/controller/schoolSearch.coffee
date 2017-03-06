angular.module 'ahaLuminateControllers'
  .controller 'SchoolSearchCtrl', [
    '$scope'
    '$rootScope'
    'TeamraiserCompanyService'
    ($scope, $rootScope, TeamraiserCompanyService) ->
  

      TeamraiserCompanyService.getSchools
        success: (response) ->
          console.log 'get school'
          console.log response

  ]