angular.module 'trPcApp'
  .factory 'NgPcTeamraiserShortcutURLService', [
    '$rootScope'
    'NgPcLuminateRESTService'
    ($rootScope, NgPcLuminateRESTService) ->
      updateShortcut: (requestData) ->
        dataString = 'method=updateShortcut'
        dataString += '&' + requestData if requestData and requestData isnt ''
        NgPcLuminateRESTService.teamraiserRequest dataString, true, true
          .then (response) ->
            response
      
      getShortcut: ->
        NgPcLuminateRESTService.teamraiserRequest 'method=getShortcut', true, true
          .then (response) ->
            response
      
      updateTeamShortcut: (requestData) ->
        dataString = 'method=updateTeamShortcut'
        dataString += '&' + requestData if requestData and requestData isnt ''
        NgPcLuminateRESTService.teamraiserRequest dataString, true, true
          .then (response) ->
            response
      
      getTeamShortcut: ->
        NgPcLuminateRESTService.teamraiserRequest 'method=getTeamShortcut', true, true
          .then (response) ->
            response
      
      updateCompanyShortcut: (requestData) ->
        dataString = 'method=updateCompanyShortcut&company_id=' + $rootScope.participantRegistration.companyInformation.companyId
        dataString += '&' + requestData if requestData and requestData isnt ''
        NgPcLuminateRESTService.teamraiserRequest dataString, true, true
          .then (response) ->
            response
      
      getCompanyShortcut: ->
        dataString = 'method=getCompanyShortcut&company_id=' + $rootScope.participantRegistration.companyInformation.companyId
        NgPcLuminateRESTService.teamraiserRequest dataString, true, true
          .then (response) ->
            response
  ]