angular.module 'trPageEditApp'
  .factory 'TeamraiserTeamPageService', [
    '$rootScope'
    'NgPageEditLuminateRESTService'
    ($rootScope, NgPageEditLuminateRESTService) ->
      getTeamPhoto: (callback) ->
        NgPageEditLuminateRESTService.luminateExtendTeamraiserRequest 'method=getTeamPhoto', true, true, callback
      
      updateTeamPageInfo: (requestData, callback) ->
        dataString = 'method=updateTeamPageInfo'
        dataString += '&' + requestData if requestData and requestData isnt ''
        NgPageEditLuminateRESTService.luminateExtendTeamraiserRequest dataString, true, true, callback
  ]