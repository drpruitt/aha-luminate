angular.module 'trPcApp'
  .factory 'NgPcTeamraiserSurveyResponseService', [
    'NgPcLuminateRESTService'
    (NgPcLuminateRESTService) ->
      updateSurveyResponses: (requestData) ->
        dataString = 'method=updateSurveyResponses'
        dataString += '&' + requestData if requestData and requestData isnt ''
        LuminateRESTService.teamraiserRequest dataString, true, true
          .then (response) ->
            response
  ]