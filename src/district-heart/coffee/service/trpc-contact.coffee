angular.module 'trPcApp'
  .factory 'NgPcContactService', [
    'NgPcLuminateRESTService'
    (NgPcLuminateRESTService) ->
      addAddressBookContact: (requestData) ->
        dataString = 'method=addAddressBookContact'
        dataString += '&' + requestData if requestData and requestData isnt ''
        NgPcLuminateRESTService.addressBookRequest dataString, true
          .then (response) ->
            response
      
      getAddressBookImportJobStatus: (requestData) ->
        dataString = 'method=getAddressBookImportJobStatus'
        dataString += '&' + requestData if requestData and requestData isnt ''
        NgPcLuminateRESTService.addressBookRequest dataString, true, true
          .then (response) ->
            response
      
      getAddressBookImportContacts: (requestData) ->
        dataString = 'method=getAddressBookImportContacts'
        dataString += '&' + requestData if requestData and requestData isnt ''
        NgPcLuminateRESTService.addressBookRequest dataString, true, true
          .then (response) ->
            response
      
      importAddressBookContacts: (requestData) ->
        dataString = 'method=importAddressBookContacts'
        dataString += '&' + requestData if requestData and requestData isnt ''
        NgPcLuminateRESTService.addressBookRequest dataString, true, true
          .then (response) ->
            response
      
      addAddressBookGroup: ->
        NgPcLuminateRESTService.addressBookRequest 'method=addAddressBookGroup', true
          .then (response) ->
            response
      
      addContactsToGroup: ->
        NgPcLuminateRESTService.addressBookRequest 'method=addContactsToGroup', true
          .then (response) ->
            response
      
      deleteTeamraiserAddressBookContacts: (requestData) ->
        dataString = 'method=deleteTeamraiserAddressBookContacts'
        dataString += '&' + requestData if requestData and requestData isnt ''
        NgPcLuminateRESTService.teamraiserRequest dataString, true, true
          .then (response) ->
            response
      
      updateTeamraiserAddressBookContact: (requestData) ->
        dataString = 'method=updateTeamraiserAddressBookContact'
        dataString += '&' + requestData if requestData and requestData isnt ''
        NgPcLuminateRESTService.teamraiserRequest dataString, true, true
          .then (response) ->
            response
      
      getTeamraiserAddressBookFilters: (requestData) ->
        dataString = 'method=getTeamraiserAddressBookFilters'
        dataString += '&' + requestData if requestData and requestData isnt ''
        NgPcLuminateRESTService.teamraiserRequest dataString, true, true
          .then (response) ->
            response
      
      getTeamraiserAddressBookContacts: (requestData) ->
        dataString = 'method=getTeamraiserAddressBookContacts'
        dataString += '&' + requestData if requestData and requestData isnt ''
        NgPcLuminateRESTService.teamraiserRequest dataString, true, true
          .then (response) ->
            response
      
      getTeamraiserAddressBookContact: ->
        NgPcLuminateRESTService.teamraiserRequest 'method=getTeamraiserAddressBookContact', true, true
          .then (response) ->
            response
  ]