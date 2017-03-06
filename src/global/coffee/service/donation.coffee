angular.module 'ahaLuminateApp'
  .factory 'DonationService', [
    'LuminateRESTService'
    (LuminateRESTService) ->
      getDonationFormInfo: (requestData) ->
        dataString = 'method=getDonationFormInfo'
        dataString += '&' + requestData if requestData and requestData isnt ''
        LuminateRESTService.donationRequest dataString
          .then (response) ->
            response
      
      donate: (requestData) ->
        dataString = 'method=donate'
        dataString += '&' + requestData if requestData and requestData isnt ''
        LuminateRESTService.donationRequest dataString
          .then (response) ->
            response
      
      startDonation: (requestData) ->
        dataString = 'method=startDonation'
        dataString += '&' + requestData if requestData and requestData isnt ''
        LuminateRESTService.donationRequest dataString
          .then (response) ->
            response
  ]