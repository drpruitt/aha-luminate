angular.module 'trPageEditApp'
  .factory 'TeamraiserParticipantPageService', [
    '$rootScope'
    'NgPageEditLuminateRESTService'
    ($rootScope, NgPageEditLuminateRESTService) ->
      getPersonalPhotos: (callback) ->
        NgPageEditLuminateRESTService.luminateExtendTeamraiserRequest 'method=getPersonalPhotos', true, true, callback
      
      updatePersonalPageInfo: (requestData, callback) ->
        dataString = 'method=updatePersonalPageInfo'
        dataString += '&' + requestData if requestData and requestData isnt ''
        NgPageEditLuminateRESTService.luminateExtendTeamraiserRequest dataString, true, true, callback
      
      updatePersonalVideoUrl: (requestData, callback) ->
        dataString = 'method=updatePersonalVideoUrl'
        dataString += '&' + requestData if requestData and requestData isnt ''
        NgPageEditLuminateRESTService.luminateExtendTeamraiserRequest dataString, true, true, callback
  ]
angular.module 'trPageEditApp'
  .factory 'TeamraiserSurveyResponseService', [
    '$rootScope'
    'NgPageEditLuminateRESTService'
    ($rootScope, NgPageEditLuminateRESTService) ->
      getSurveyResponses: (callback) ->
        NgPageEditLuminateRESTService.luminateExtendTeamraiserRequest 'method=getSurveyResponses', true, true, callback
  ]