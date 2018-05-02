angular.module 'trPcControllers'
  .controller 'EmailContactsListViewCtrl', [
    '$rootScope'
    '$scope'
    '$window'
    '$routeParams'
    '$location'
    '$httpParamSerializer'
    '$translate'
    '$uibModal'
    'APP_INFO'
    'TeamraiserEmailService'
    'ContactService'
    ($rootScope, $scope, $window, $routeParams, $location, $httpParamSerializer, $translate, $uibModal, APP_INFO, TeamraiserEmailService, ContactService) ->
      $scope.filter = $routeParams.filter
      
      $scope.emailPromises = []
      
      $scope.messageCounts = {}
      messageTypes = [
        'draft'
        'sentMessage'
      ]
      angular.forEach messageTypes, (messageType) ->
        apiMethod = 'get' + messageType.charAt(0).toUpperCase() + messageType.slice(1) + 's'
        messageCountPromise = TeamraiserEmailService[apiMethod] 'list_page_size=1'
          .then (response) ->
            $scope.messageCounts[messageType + 's'] = response.data[apiMethod + 'Response'].totalNumberResults
            response
        $scope.emailPromises.push messageCountPromise

      getContactString = (contact) ->
        contactData = ''
        if contact?.firstName
          contactData += contact.firstName
        if contact?.lastName
          if contactData isnt ''
            contactData += ' '
          contactData += contact.lastName
        if contact?.email
          if contactData isnt ''
            contactData += ' '
          contactData += '<' + contact.email + '>'
        contactData

      isContactSelected = (contact) ->
        contactData = getContactString contact
        contactIndex = $rootScope.selectedContacts.contacts.indexOf contactData
        contactIndex isnt -1

      countContactSelected = (contacts) ->
        count = 0
        angular.forEach contacts, (contact) ->
          if contact?.selected
            count = count + 1
        count

      isAllContactsSelected = () ->
        $scope.addressBookContacts.allContacts.length is countContactSelected $scope.addressBookContacts.allContacts
      
      $scope.contactCounts = {}
      contactFilters = [
        'email_rpt_show_all'
        'email_rpt_show_never_emailed'
        'email_rpt_show_nondonors_followup'
        'email_rpt_show_unthanked_donors'
        'email_rpt_show_donors'
        'email_rpt_show_nondonors'
        'email_rpt_show_teammates'
        'email_rpt_show_lybunt_teammates'
        'email_rpt_show_ly_donors'
      ]
      $scope.addressBookContacts = 
        page: 1
        allContactsSelected: false
      angular.forEach contactFilters, (filter) ->
        if filter is $scope.filter
          $scope.getContacts = ->
            pageNumber = $scope.addressBookContacts.page - 1
            contactsPromise = ContactService.getTeamraiserAddressBookContacts 'tr_ab_filter=' + filter + '&skip_groups=true&list_page_size=10&list_page_offset=' + pageNumber
              .then (response) ->
                $scope.contactCounts[filter] = $scope.addressBookContacts.totalNumber = response.data.getTeamraiserAddressBookContactsResponse.totalNumberResults
                addressBookContacts = response.data.getTeamraiserAddressBookContactsResponse.addressBookContact
                addressBookContacts = [addressBookContacts] if not angular.isArray addressBookContacts
                contacts = []
                angular.forEach addressBookContacts, (contact) ->
                  if contact
                    contact.selected = isContactSelected contact
                    contacts.push contact
                $scope.addressBookContacts.contacts = contacts
                response
            $scope.emailPromises.push contactsPromise
          $scope.getContacts()
          $scope.getAllContacts = ->
            if not $scope.addressBookContacts.getAllPage
              $scope.addressBookContacts.allContacts = []
              $scope.addressBookContacts.getAllPage = 0
            pageNumber = $scope.addressBookContacts.getAllPage
            allContactsPromise = ContactService.getTeamraiserAddressBookContacts 'tr_ab_filter=' + filter + '&skip_groups=true&list_page_size=200&list_page_offset=' + pageNumber
              .then (response) ->
                totalNumber = response.data.getTeamraiserAddressBookContactsResponse.totalNumberResults
                addressBookContacts = response.data.getTeamraiserAddressBookContactsResponse.addressBookContact
                addressBookContacts = [addressBookContacts] if not angular.isArray addressBookContacts
                contacts = []
                angular.forEach addressBookContacts, (contact) ->
                  if contact
                    contact.selected = isContactSelected contact
                    $scope.addressBookContacts.allContacts.push contact
                if $scope.addressBookContacts.allContacts.length < totalNumber
                  $scope.addressBookContacts.getAllPage = $scope.addressBookContacts.getAllPage + 1
                  $scope.getAllContacts()
                else
                  delete $scope.addressBookContacts.getAllPage
                  $scope.addressBookContacts.allContactsSelected = isAllContactsSelected()
                  response
            $scope.emailPromises.push allContactsPromise
          $scope.getAllContacts()
        else
          contactCountPromise = ContactService.getTeamraiserAddressBookContacts 'tr_ab_filter=' + filter + '&skip_groups=true'
            .then (response) ->
              $scope.contactCounts[filter] = response.data.getTeamraiserAddressBookContactsResponse?.totalNumberResults or '0'
              response
          $scope.emailPromises.push contactCountPromise
      
      filterNames = 
        email_rpt_show_all: 'All Contacts'
        email_rpt_show_never_emailed: 'Never Emailed'
        email_rpt_show_nondonors_followup: 'Needs Follow-Up'
        email_rpt_show_unthanked_donors: 'Unthanked Donors'
        email_rpt_show_donors: 'Donors'
        email_rpt_show_nondonors: 'Non-Donors'
        email_rpt_show_teammates : 'Current Teammates'
        email_rpt_show_lybunt_teammates : 'Past Teammates'
        email_rpt_show_ly_donors: 'Past Donors'

      
      $translate [ 'contacts_groups_all', 'filter_email_rpt_show_never_emailed', 'filter_email_rpt_show_nondonors_followup', 'filter_email_rpt_show_unthanked_donors', 'filter_email_rpt_show_donors', 'filter_email_rpt_show_nondonors', 'filter_email_rpt_show_teammates', 'filter_email_rpt_show_lybunt_teammates', 'filter_email_rpt_show_ly_donors' ]
        .then (translations) ->
          filterNames.email_rpt_show_all = translations.contacts_groups_all
          filterNames.email_rpt_show_never_emailed = translations.filter_email_rpt_show_never_emailed
          filterNames.email_rpt_show_nondonors_followup = translations.filter_email_rpt_show_nondonors_followup
          filterNames.email_rpt_show_unthanked_donors = translations.filter_email_rpt_show_unthanked_donors
          filterNames.email_rpt_show_donors = translations.filter_email_rpt_show_donors
          filterNames.email_rpt_show_nondonors = translations.filter_email_rpt_show_nondonors
          filterNames.email_rpt_show_teammates = translations.filter_email_rpt_show_teammates
          filterNames.email_rpt_show_lybunt_teammates = translations.filter_email_rpt_show_lybunt_teammates
          filterNames.email_rpt_show_ly_donors = translations.filter_email_rpt_show_ly_donors
        , (translationIds) ->
          filterNames.email_rpt_show_all = translationIds.contacts_groups_all
          filterNames.email_rpt_show_never_emailed = translationIds.filter_email_rpt_show_never_emailed
          filterNames.email_rpt_show_nondonors_followup = translationIds.filter_email_rpt_show_nondonors_followup
          filterNames.email_rpt_show_unthanked_donors = translationIds.filter_email_rpt_show_unthanked_donors
          filterNames.email_rpt_show_donors = translationIds.filter_email_rpt_show_donors
          filterNames.email_rpt_show_nondonors = translationIds.filter_email_rpt_show_nondonors
          filterNames.email_rpt_show_teammates = translationIds.filter_email_rpt_show_teammates
          filterNames.email_rpt_show_lybunt_teammates = translationIds.filter_email_rpt_show_lybunt_teammates
          filterNames.email_rpt_show_ly_donors = translationIds.filter_email_rpt_show_ly_donors
      
      $scope.filterName = filterNames[$scope.filter]
      
      $scope.clearAllContactAlerts = ->
        $scope.clearAddContactAlerts()
        $scope.clearImportContactsAlerts()
        $scope.clearEditContactAlerts()
        $scope.clearDeleteContactAlerts()
      
      $scope.clearAddContactAlerts = ->
        if $scope.addContactError
          delete $scope.addContactError
        if $scope.addContactSuccess
          delete $scope.addContactSuccess
      
      $scope.resetNewContact = ->
        $scope.newContact =
          first_name: ''
          last_name: ''
          email: ''
      
      $scope.addContact = ->
        $scope.clearAllContactAlerts()
        $scope.resetNewContact()
        $scope.addContactModal = $uibModal.open 
          scope: $scope
          templateUrl: APP_INFO.rootPath + 'dist/heart-walk/html/participant-center/modal/addContact.html'
      
      closeAddContactModal = ->
        $scope.addContactModal.close()
      
      $scope.cancelAddContact = ->
        $scope.clearAddContactAlerts()
        closeAddContactModal()
      
      $scope.addNewContact = ->
        $scope.clearAddContactAlerts()
        if not $scope.newContact.email or $scope.newContact.email is ''
          $translate 'contact_add_failure_email'
            .then (translation) ->
              $scope.addContactError = translation
            , (translationId) ->
              $scope.addContactError = translationId
        else
          addContactPromise = ContactService.addAddressBookContact $httpParamSerializer($scope.newContact)
            .then (response) ->
              if response.data.errorResponse
                if response.data.errorResponse.message
                  $scope.addContactError = response.data.errorResponse.message
                else
                  $translate 'contact_add_failure_unknown'
                    .then (translation) ->
                      $scope.addContactError = translation
                    , (translationId) ->
                      $scope.addContactError = translationId
              else
                $translate 'contact_add_success'
                  .then (translation) ->
                    $scope.addContactSuccess = translation
                  , (translationId) ->
                    $scope.addContactSuccess = translationId
                closeAddContactModal()
                $scope.getContacts()
                $scope.getAllContacts()
              response
          $scope.emailPromises.push addContactPromise
      
      $scope.clearImportContactsAlerts = ->
        if $scope.importContactsError
          delete $scope.importContactsError
        if $scope.importContactsSuccess
          delete $scope.importContactsSuccess
      
      $scope.resetImportContacts = ->
        $scope.contactImport = 
          step: 'choose-type'
          import_type: ''
          jobEvents: [
            {
              message: '1. Waiting for your consent ...'
            }
          ]
          contactsToAdd: []
      
      $scope.importContacts = ->
        $scope.clearAllContactAlerts()
        $scope.resetImportContacts()
        $scope.importContactsModal = $uibModal.open 
          scope: $scope
          templateUrl: APP_INFO.rootPath + 'dist/heart-walk/html/participant-center/modal/importContacts.html'
      
      closeImportContactsModal = ->
        $scope.importContactsModal.close()
      
      $scope.cancelImportContacts = ->
        $scope.clearImportContactsAlerts()
        closeImportContactsModal()
      
      $scope.chooseImportContactType = ->
        importType = $scope.contactImport.import_type
        if not importType or importType is ''
          # TODO: error message
        else
          if importType is 'csv'
            $scope.contactImport.step = 'csv-upload'
          else
            $scope.contactImport.step = 'online-consent'
            $window.open APP_INFO.rootPath + 'dist/heart-walk/html/participant-center/popup/address-book-import.html?import_source=' + $scope.contactImport.import_type, 'startimport', 'location=no,menubar=no,toolbar=no,height=400'
            return false
      
      window.trPcContactImport = 
        buildAddressBookImport: (importJobId) ->
          ContactService.getAddressBookImportJobStatus 'import_job_id=' + importJobId
            .then (response) ->
              if response.data.errorResponse
                # TODO
              else
                jobStatus = response.data.getAddressBookImportJobStatusResponse?.jobStatus
                if not jobStatus
                  # TODO
                else
                  if jobStatus is 'PENDING' or jobStatus is 'FAILURE'
                    events = response.data.getAddressBookImportJobStatusResponse.events?.event
                    if not events
                      $scope.updateImportJobEvents()
                    else
                      events = [events] if not angular.isArray events
                      jobEvents = []
                      angular.forEach events, (event) ->
                        jobEvents.push 
                          message: event
                      $scope.updateImportJobEvents jobEvents
                    trPcContactImport.buildAddressBookImport importJobId
                  else if jobStatus is 'SUCCESS'
                    ContactService.getAddressBookImportContacts 'import_job_id=' + importJobId
                      .then (response) ->
                        if response.data.errorResponse
                          # TODO
                        else
                          contacts = response.data.getAddressBookImportContactsResponse?.contact
                          if not contacts
                            $scope.setContactsAvailableForImport()
                          else
                            contacts = [contacts] if not angular.isArray contacts
                            contactsAvailableForImport = []
                            angular.forEach contacts, (contact) ->
                              if contact
                                firstName = contact.firstName
                                lastName = contact.lastName
                                email = contact.email
                                if firstName and not angular.isString firstName
                                  delete contact.firstName
                                  firstName = undefined
                                if lastName and not angular.isString lastName
                                  delete contact.lastName
                                if email and not angular.isString email
                                  delete contact.email
                                  email = undefined
                                if firstName or email
                                  contactsAvailableForImport.push contact
                            $scope.setContactsAvailableForImport contactsAvailableForImport
      
      $scope.updateImportJobEvents = (jobEvents) ->
        if jobEvents and jobEvents.length isnt 0
          $scope.contactImport.jobEvents = jobEvents
        if not $scope.$$phase
          $scope.$apply()
      
      $scope.setContactsAvailableForImport = (contactsAvailableForImport) ->
        $scope.contactImport.step = 'contacts-available-for-import'
        $scope.contactsAvailableForImport = contactsAvailableForImport or []
        if not $scope.$$phase
          $scope.$apply()
      
      $scope.selectAllContactsToAdd = ($event) ->
        if $event
          $event.preventDefault()
        contactsAvailableForImport = []
        $scope.contactImport.contactsToAdd = []
        angular.forEach $scope.contactsAvailableForImport, (contactAvailableForImport) ->
          contactAvailableForImport.selected = true
          contactsAvailableForImport.push contactAvailableForImport
          contactData = ''
          if contactAvailableForImport.firstName
            contactData += '"' + contactAvailableForImport.firstName + '"'
          contactData += ', '
          if contactAvailableForImport.lastName
            contactData += '"' + contactAvailableForImport.lastName + '"'
          contactData += ', '
          if contactAvailableForImport.email
            contactData += '"' + contactAvailableForImport.email + '"'
          $scope.contactImport.contactsToAdd.push contactData
        $scope.contactsAvailableForImport = contactsAvailableForImport
      
      $scope.deselectAllContactsToAdd = ($event) ->
        if $event
          $event.preventDefault()
        contactsAvailableForImport = []
        angular.forEach $scope.contactsAvailableForImport, (contactAvailableForImport) ->
          contactAvailableForImport.selected = false
          contactsAvailableForImport.push contactAvailableForImport
        $scope.contactsAvailableForImport = contactsAvailableForImport
        $scope.contactImport.contactsToAdd = []
      
      $scope.toggleContactToAdd = (contact) ->
        contactData = ''
        if contact.firstName
          contactData += '"' + contact.firstName + '"'
        contactData += ', '
        if contact.lastName
          contactData += '"' + contact.lastName + '"'
        contactData += ', '
        if contact.email
          contactData += '"' + contact.email + '"'
        contactToAddIndex = $scope.contactImport.contactsToAdd.indexOf contactData
        if contactToAddIndex is -1
          $scope.contactImport.contactsToAdd.push contactData
        else
          $scope.contactImport.contactsToAdd.splice contactToAddIndex, 1
      
      $scope.chooseContactsToImport = ->
        $scope.clearImportContactsAlerts()
        if $scope.contactImport.contactsToAdd.length is 0
          $scope.importContactsError = 'You must select at least one contact to continue this process.'
        else
          ContactService.importAddressBookContacts 'contacts_to_add=' + encodeURIComponent($scope.contactImport.contactsToAdd.join('\n'))
            .then (response) ->
              if response.data.errorResponse
                $scope.importContactsError = response.data.errorResponse.message
              else
                errorContacts = response.data.importAddressBookContactsResponse?.errorContact
                if errorContacts
                  errorContacts = [errorContacts] if not angular.isArray errorContacts
                potentialDuplicateContacts = response.data.importAddressBookContactsResponse?.potentialDuplicateContact
                if potentialDuplicateContacts
                  potentialDuplicateContacts = [potentialDuplicateContacts] if not angular.isArray potentialDuplicateContacts
                duplicateContacts = response.data.importAddressBookContactsResponse?.duplicateContact
                if duplicateContacts
                  duplicateContacts = [duplicateContacts] if not angular.isArray duplicateContacts
                savedContacts = response.data.importAddressBookContactsResponse?.savedContact
                if savedContacts
                  savedContacts = [savedContacts] if not angular.isArray savedContacts
                # TODO: handle errorContacts, potentialDuplicateContacts, and duplicateContacts
                $scope.importContactsSuccess = true
                closeImportContactsModal()
                $scope.getContacts()
                $scope.getAllContacts()
      
      $scope.uploadContactsCSV = ->
        angular.element('.js--import-contacts-csv-form').submit()
        return false
      
      $scope.handleContactsCSV = (csvIframe) ->
        csvIframeContent = jQuery(csvIframe).contents().text()
        if csvIframeContent
          csvIframeJSON = jQuery.parseJSON csvIframeContent
          if csvIframeJSON.errorResponse
            # TODO
          else
            confidenceLevel = csvIframeJSON.parseCsvContactsResponse?.confidenceLevel
            # TODO: confidenceLevel
            proposedMapping = csvIframeJSON.parseCsvContactsResponse?.proposedMapping
            if proposedMapping
              firstNameColumnIndex = Number proposedMapping.firstNameColumnIndex
              lastNameColumnIndex = Number proposedMapping.lastNameColumnIndex
              emailColumnIndex = Number proposedMapping.emailColumnIndex
              csvDataRows = csvIframeJSON.parseCsvContactsResponse?.csvDataRows?.csvDataRow
              if not csvDataRows
                # TODO
              else
                csvDataRows = [csvDataRows] if not angular.isArray csvDataRows
                contactsAvailableForImport = []
                angular.forEach csvDataRows, (csvDataRow) ->
                  if csvDataRow
                    csvValue = csvDataRow.csvValue
                    firstName = csvValue[firstNameColumnIndex]
                    lastName = csvValue[lastNameColumnIndex]
                    email = csvValue[emailColumnIndex]
                    contact =
                      firstName: firstName
                      lastName: lastName
                      email: email
                    if firstName and not angular.isString firstName
                      delete contact.firstName
                      firstName = undefined
                    if lastName and not angular.isString lastName
                      delete contact.lastName
                    if email and not angular.isString email
                      delete contact.email
                      email = undefined
                    if firstName or email
                      contactsAvailableForImport.push contact
                $scope.setContactsAvailableForImport contactsAvailableForImport
      
      $scope.resetSelectedContacts = ->
        $rootScope.selectedContacts = 
          contacts: []
      if not $rootScope.selectedContacts?.contacts
        $scope.resetSelectedContacts()
      
      $scope.toggleContact = (contact) ->
        contactData = getContactString contact
        contactIndex = $rootScope.selectedContacts.contacts.indexOf contactData
        if contactIndex is -1
          $rootScope.selectedContacts.contacts.push contactData
        else
          $rootScope.selectedContacts.contacts.splice contactIndex, 1
        angular.forEach $scope.addressBookContacts.allContacts, (aContact) ->
          if contactData is getContactString aContact
            aContact.selected = contactIndex is -1
          aContact
        $scope.addressBookContacts.allContactsSelected = isAllContactsSelected()
        $scope.addressBookContacts.allContactsSelected

      $scope.toggleAllContacts = ->
        selected = not $scope.addressBookContacts.allContactsSelected
        angular.forEach $scope.addressBookContacts.contacts, (contact) ->
          contact.selected = selected
        angular.forEach $scope.addressBookContacts.allContacts, (contact) ->
          contact.selected = selected
          if selected isnt isContactSelected contact
            $scope.toggleContact contact
        $scope.addressBookContacts.allContactsSelected = selected
        $scope.addressBookContacts.allContactsSelected
      
      $scope.clearEditContactAlerts = ->
        if $scope.editContactError
          delete $scope.editContactError
        if $scope.editContactSuccess
          delete $scope.editContactSuccess
      
      $scope.selectContact = (contact) ->
        $scope.clearAllContactAlerts()
        $scope.selectedContact = contact
        $scope.updatedContact = 
          contact_id: $scope.selectedContact.id
          first_name: $scope.selectedContact.firstName
          last_name: $scope.selectedContact.lastName
          email: $scope.selectedContact.email
        $scope.editContactModal = $uibModal.open
          scope: $scope
          templateUrl: APP_INFO.rootPath + 'dist/heart-walk/html/participant-center/modal/editContact.html'
      
      closeEditContactModal = ->
        $scope.editContactModal.close()
      
      $scope.cancelEditContact = ->
        delete $scope.selectedContact
        $scope.clearEditContactAlerts()
        closeEditContactModal()
      
      $scope.saveUpdatedContact = ->
        $scope.clearEditContactAlerts()
        if not $scope.selectedContact
          # TODO
        else
          updateContactPromise = ContactService.updateTeamraiserAddressBookContact $httpParamSerializer($scope.updatedContact)
            .then (response) ->
              if response.data.errorResponse
                if response.data.errorResponse.message
                  $scope.editContactError = response.data.errorResponse.message
                else
                  $translate 'contacts_warn_delete_failure_body'
                    .then (translation) ->
                      $scope.editContactError = translation
                    , (translationId) ->
                      $scope.editContactError = translationId
              else
                $translate 'contact_edit_success'
                  .then (translation) ->
                    $scope.editContactSuccess = translation
                  , (translationId) ->
                    $scope.editContactSuccess = translation
                closeEditContactModal()
                window.scrollTo 0, 0
                # TODO: update selected contacts
                $scope.getContacts()
                $scope.getAllContacts()
              response
          $scope.emailPromises.push updateContactPromise
      
      $scope.clearDeleteContactAlerts = ->
        if $scope.deleteContactError
          delete $scope.deleteContactError
        if $scope.deleteContactSuccess
          delete $scope.deleteContactSuccess
      
      $scope.deleteContact = (contactId) ->
        $scope.clearAllContactAlerts()
        $scope.deleteContactId = contactId
        $scope.deleteContactModal = $uibModal.open 
          scope: $scope
          templateUrl: APP_INFO.rootPath + 'dist/heart-walk/html/participant-center/modal/deleteContact.html'
      
      closeDeleteContactModal = ->
        delete $scope.deleteContactId
        $scope.deleteContactModal.close()
      
      $scope.cancelDeleteContact = ->
        closeDeleteContactModal()
      
      $scope.confirmDeleteContact = ->
        if not $scope.deleteContactId
          # TODO
        else
          deleteContactPromise = ContactService.deleteTeamraiserAddressBookContacts 'contact_ids=' + $scope.deleteContactId
            .then (response) ->
              if response.data.errorResponse
                if response.data.errorResponse.message
                  $scope.deleteContactError = response.data.errorResponse.message
                else
                  $translate 'contacts_warn_delete_failure_body'
                    .then (translation) ->
                      $scope.deleteContactError = translation
                    , (translationId) ->
                      $scope.deleteContactError = translationId
              else
                $translate 'contacts_delete_success'
                  .then (translation) ->
                    $scope.deleteContactSuccess = translation
                  , (translationId) ->
                    $scope.deleteContactSuccess = translationId
              closeDeleteContactModal()
              window.scrollTo 0, 0
              # TODO: update selected contacts
              $scope.getContacts()
              $scope.getAllContacts()
              response
          $scope.emailPromises.push deleteContactPromise
      
      $scope.emailSelectedContacts = ->
        $location.path '/email/compose'
  ]