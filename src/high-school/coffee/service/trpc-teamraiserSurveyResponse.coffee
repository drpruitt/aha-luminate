angular.module 'trPcApp'
  .factory 'NgPcTeamraiserSurveyResponseService', [
    'NgPcLuminateRESTService'
    (NgPcLuminateRESTService) ->
      getSurveyResponses: (requestData) ->
        dataString = 'method=getSurveyResponses&use_filters=true'
        dataString += '&' + requestData if requestData and requestData isnt ''
        NgPcLuminateRESTService.teamraiserRequest dataString, true, true
          .then (response) ->
            response
      
      updateSurveyResponses: (requestData) ->
        dataString = 'method=updateSurveyResponses'
        dataString += '&' + requestData if requestData and requestData isnt ''
        NgPcLuminateRESTService.teamraiserRequest dataString, true, true
          .then (response) ->
            response
  ]