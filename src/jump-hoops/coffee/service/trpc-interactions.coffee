angular.module 'trPcApp'
  .factory 'NgPcInteractionService', [
    'NgPcLuminateRESTService'
    (NgPcLuminateRESTService) ->
      getInteraction: (requestData) ->
        dataString = 'method=getUserInteractions'
        dataString += '&' + requestData if requestData and requestData isnt ''
        NgPcLuminateRESTService.consRequest dataString, true
          .then (response) ->
            response
      
      logInteraction: (requestData) ->
        dataString = 'method=logInteraction'
        dataString += '&' + requestData if requestData and requestData isnt ''
        NgPcLuminateRESTService.consRequest dataString, true
          .then (response) ->
            response
      
      updateInteraction: (requestData) ->
        dataString = 'method=updateInteraction'
        dataString += '&' + requestData if requestData and requestData isnt ''
        NgPcLuminateRESTService.consRequest dataString, true
          .then (response) ->
            response

  ]