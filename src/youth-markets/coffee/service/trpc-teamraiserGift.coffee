angular.module 'trPcApp'
  .factory 'NgPcTeamraiserGiftService', [
    'NgPcLuminateRESTService'
    (NgPcLuminateRESTService) ->
      getGiftCategories: ->
        NgPcLuminateRESTService.teamraiserRequest 'method=getGiftCategories', true, true
          .then (response) ->
            response
      
      addGift: (requestData) ->
        dataString = 'method=addGift'
        dataString += '&' + requestData if requestData and requestData isnt ''
        NgPcLuminateRESTService.teamraiserRequest dataString, true, true
          .then (response) ->
            response
      
      deleteGift: (requestData) ->
        dataString = 'method=deleteGift'
        dataString += '&' + requestData if requestData and requestData isnt ''
        NgPcLuminateRESTService.teamraiserRequest dataString, true, true
          .then (response) ->
            response
      
      acknowledgeGift: (requestData) ->
        dataString = 'method=acknowledgeGifts'
        dataString += '&' + requestData if requestData and requestData isnt ''
        NgPcLuminateRESTService.teamraiserRequest dataString, true, true
          .then (response) ->
            response
      
      getGifts: (requestData) ->
        dataString = 'method=getGifts'
        dataString += '&' + requestData if requestData and requestData isnt ''
        NgPcLuminateRESTService.teamraiserRequest dataString, true, true
          .then (response) ->
            response
      
      getTeamGifts: (requestData) ->
        dataString = 'method=getTeamGifts'
        dataString += '&' + requestData if requestData and requestData isnt ''
        NgPcLuminateRESTService.teamraiserRequest dataString, true, true
          .then (response) ->
            response
  ]