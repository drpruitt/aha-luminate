angular.module 'trPageEditApp'
  .factory 'TeamraiserCompanyPageService', [
    '$rootScope'
    'NgPageEditLuminateRESTService'
    ($rootScope, NgPageEditLuminateRESTService) ->
      getCompanyPhoto: (callback) ->
        NgPageEditLuminateRESTService.luminateExtendTeamraiserRequest 'method=getCompanyPhoto', true, true, callback
      
      updateCompanyPageInfo: (requestData, callback) ->
        dataString = 'method=updateCompanyPageInfo'
        dataString += '&' + requestData if requestData and requestData isnt ''
        NgPageEditLuminateRESTService.luminateExtendTeamraiserRequest dataString, true, true, callback
  ]