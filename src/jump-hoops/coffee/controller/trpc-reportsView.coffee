angular.module 'trPcControllers'
  .controller 'NgPcReportsViewCtrl', [
    '$rootScope'
    '$scope'
    '$filter'
    '$location'
    'NgPcTeamraiserEmailService'
    'NgPcTeamraiserGiftService'
    'NgPcTeamraiserReportsService'
    ($rootScope, $scope, $filter, $location, NgPcTeamraiserEmailService, NgPcTeamraiserGiftService, NgPcTeamraiserReportsService) ->
      $scope.reportPromises = []
      
      $scope.activeReportTab = if $scope.participantRegistration.companyInformation.isCompanyCoordinator is 'true' then 0 else 1
      
      NgPcTeamraiserEmailService.getSuggestedMessages()
        .then (response) ->
          suggestedMessages = response.data.getSuggestedMessagesResponse.suggestedMessage
          suggestedMessages = [suggestedMessages] if not angular.isArray suggestedMessages
          $scope.suggestedMessages = []
          angular.forEach suggestedMessages, (message) ->
            if message.active is 'true'
              if $scope.participantRegistration.companyInformation?.isCompanyCoordinator isnt 'true'
                if message.name.indexOf('Coordinator:') is -1
                  message.name = message.name.split('Student: ')[1]
                  $scope.suggestedMessages.push message
              else
                if message.name.indexOf('Student:') is -1
                  message.name = message.name.split('Coordinator: ')[1]
                  $scope.suggestedMessages.push message
          angular.forEach $scope.suggestedMessages, (suggestedMessage) ->
            messageType = suggestedMessage.messageType
            if messageType
              if messageType.toLowerCase() is 'thanks' and not $scope.thankYouMessageId
                $scope.thankYouMessageId = suggestedMessage.messageId
      
      $scope.participantGifts =
        sortColumn: 'date_recorded'
        sortAscending: false
        page: 1
      $scope.getGifts = ->
        pageNumber = $scope.participantGifts.page - 1
        personalGiftsPromise = NgPcTeamraiserGiftService.getGifts 'list_sort_column=' + $scope.participantGifts.sortColumn + '&list_ascending=' + $scope.participantGifts.sortAscending + '&list_page_size=500&list_page_offset=' + pageNumber
          .then (response) ->
            if response.data.errorResponse
              $scope.participantGifts.gifts = []
              $scope.participantGifts.totalNumber = 0
            else
              gifts = response.data.getGiftsResponse.gift
              if not gifts
                $scope.participantGifts.gifts = []
              else
                gifts = [gifts] if not angular.isArray gifts
                participantGifts = []
                angular.forEach gifts, (gift) ->
                  gift.contact =
                    firstName: gift.name.first
                    lastName: gift.name.last
                    email: gift.email
                  gift.giftAmountFormatted = $filter('currency') gift.giftAmount / 100, '$', 0
                  if gift.giftMessage
                    gift.showMessage = 'false'
                  participantGifts.push gift
                $scope.participantGifts.gifts = participantGifts
              $scope.participantGifts.totalNumber = if response.data.getGiftsResponse.totalNumberResults then Number(response.data.getGiftsResponse.totalNumberResults) else 0
            response
        $scope.reportPromises.push personalGiftsPromise
      $scope.getGifts()
      
      $scope.thankParticipantDonor = (participantGift) ->
        if not $rootScope.selectedContacts
          $rootScope.selectedContacts = {}
        $rootScope.selectedContacts.contacts = []
        if participantGift
          giftContact = null
          if participantGift.contact.firstName
            giftContact = participantGift.contact.firstName
            if participantGift.contact.lastName
              giftContact += ' ' + participantGift.contact.lastName
          if participantGift.contact.email
            if not giftContact
              giftContact = '<'
            else
              giftContact += ' <'
            giftContact += participantGift.contact.email + '>'
          if giftContact
            $rootScope.selectedContacts.contacts = [giftContact]
        if $scope.thankYouMessageId
          $location.path '/email/compose/suggestedMessage/' + $scope.thankYouMessageId
        else
          $location.path '/email/compose/'
      
      $scope.thankAllParticipantDonors = ->
        if not $rootScope.selectedContacts
          $rootScope.selectedContacts = {}
        $rootScope.selectedContacts.contacts = []
        if $scope.participantGifts.gifts.length > 0
          angular.forEach $scope.participantGifts.gifts, (participantGift) ->
            giftContact = null
            if participantGift.contact.firstName
              giftContact = participantGift.contact.firstName
              if participantGift.contact.lastName
                giftContact += ' ' + participantGift.contact.lastName
            if participantGift.contact.email
              if not giftContact
                giftContact = '<'
              else
                giftContact += ' <'
              giftContact += participantGift.contact.email + '>'
            if giftContact
              $rootScope.selectedContacts.contacts.push giftContact
        if $scope.thankYouMessageId
          $location.path '/email/compose/suggestedMessage/' + $scope.thankYouMessageId
        else
          $location.path '/email/compose/'
      
      if $scope.participantRegistration.aTeamCaptain is 'true'
        $scope.teamGifts =
          sortColumn: 'date_recorded'
          sortAscending: false
          page: 1
        $scope.getTeamGifts = ->
          pageNumber = $scope.teamGifts.page - 1
          personalGiftsPromise = NgPcTeamraiserGiftService.getTeamGifts 'list_sort_column=' + $scope.teamGifts.sortColumn + '&list_ascending=' + $scope.teamGifts.sortAscending + '&list_page_size=500&list_page_offset=' + pageNumber
            .then (response) ->
              if response.data.errorResponse
                $scope.teamGifts.gifts = []
                $scope.teamGifts.totalNumber = 0
              else
                gifts = response.data.getGiftsResponse.gift
                if not gifts
                  $scope.teamGifts.gifts = []
                else
                  gifts = [gifts] if not angular.isArray gifts
                  teamGifts = []
                  angular.forEach gifts, (gift) ->
                    gift.contact =
                      firstName: gift.name.first
                      lastName: gift.name.last
                      email: gift.email
                    gift.giftAmountFormatted = $filter('currency') gift.giftAmount / 100, '$', 0
                    teamGifts.push gift
                  $scope.teamGifts.gifts = teamGifts
                $scope.teamGifts.totalNumber = if response.data.getGiftsResponse.totalNumberResults then Number(response.data.getGiftsResponse.totalNumberResults) else 0
              response
          $scope.reportPromises.push personalGiftsPromise
        $scope.getTeamGifts()
        
        $scope.thankTeamDonor = (teamGift) ->
          if not $rootScope.selectedContacts
            $rootScope.selectedContacts = {}
          $rootScope.selectedContacts.contacts = []
          if teamGift
            giftContact = null
            if teamGift.contact.firstName
              giftContact = teamGift.contact.firstName
              if teamGift.contact.lastName
                giftContact += ' ' + teamGift.contact.lastName
            if teamGift.contact.email
              if not giftContact
                giftContact = '<'
              else
                giftContact += ' <'
              giftContact += teamGift.contact.email + '>'
            if giftContact
              $rootScope.selectedContacts.contacts = [giftContact]
          if $scope.thankYouMessageId
            $location.path '/email/compose/suggestedMessage/' + $scope.thankYouMessageId
          else
            $location.path '/email/compose/'
        
        $scope.thankAllTeamDonors = ->
          if not $rootScope.selectedContacts
            $rootScope.selectedContacts = {}
          $rootScope.selectedContacts.contacts = []
          if $scope.teamGifts.gifts.length > 0
            angular.forEach $scope.teamGifts.gifts, (teamGift) ->
              giftContact = null
              if teamGift.contact.firstName
                giftContact = teamGift.contact.firstName
                if teamGift.contact.lastName
                  giftContact += ' ' + teamGift.contact.lastName
              if teamGift.contact.email
                if not giftContact
                  giftContact = '<'
                else
                  giftContact += ' <'
                giftContact += teamGift.contact.email + '>'
              if giftContact
                $rootScope.selectedContacts.contacts.push giftContact
          if $scope.thankYouMessageId
            $location.path '/email/compose/suggestedMessage/' + $scope.thankYouMessageId
          else
            $location.path '/email/compose/'
      
      if $scope.participantRegistration.companyInformation.isCompanyCoordinator is 'true'
        $scope.schoolDetailStudents =
          downloadHeaders: [
            'Name'
            'Amount'
            'Ecards'
            'Emails'
            'T-shirt'
            'Teacher'
            'Challenge'
        ]
        schoolDetailReportPromise = NgPcTeamraiserReportsService.getSchoolDetailReport()
          .then (response) ->
            if response.data.errorResponse
              $scope.schoolDetailStudents.students = []
              $scope.schoolDetailStudents.downloadData = []
            else
              reportHtml = response.data.getSchoolDetailReport.report
              $reportTable = angular.element('<div>' + reportHtml + '</div>').find 'table'
              if $reportTable.length is 0
                $scope.schoolDetailStudents.students = []
                $scope.schoolDetailStudents.downloadData = []
              else
                $reportTableRows = $reportTable.find 'tr'
                if $reportTableRows.length is 0
                  $scope.schoolDetailStudents.students = []
                  $scope.schoolDetailStudents.downloadData = []
                else
                  schoolDetailStudents = []
                  schoolDetailDownloadData = []
                  angular.forEach $reportTableRows, (reportTableRow) ->
                    $reportTableRow = angular.element reportTableRow
                    firstName = jQuery.trim $reportTableRow.find('td').eq(8).text()
                    lastName = jQuery.trim $reportTableRow.find('td').eq(9).text()
                    amount = Number jQuery.trim($reportTableRow.find('td').eq(10).text())
                    amountFormatted = $filter('currency') jQuery.trim($reportTableRow.find('td').eq(10).text()), '$'
                    ecardsSent = Number jQuery.trim($reportTableRow.find('td').eq(13).text())
                    emailsSent = Number jQuery.trim($reportTableRow.find('td').eq(12).text())
                    tshirtSize = jQuery.trim $reportTableRow.find('td').eq(14).text()
                    teacherName = jQuery.trim $reportTableRow.find('td').eq(6).text()
                    challenge = jQuery.trim($reportTableRow.find('td').eq(15).text()).replace('1. ', '').replace('2. ', '').replace('3. ', '').replace '4. ', ''
                    schoolDetailStudents.push
                      firstName: firstName
                      lastName: lastName
                      amount: amount
                      amountFormatted: amountFormatted.replace '.00', ''
                      ecardsSent: ecardsSent
                      emailsSent: emailsSent
                      tshirtSize: tshirtSize
                      teacherName: teacherName
                      challenge: challenge
                    schoolDetailDownloadData.push [
                      firstName + ' ' + jQuery.trim $reportTableRow.find('td').eq(9).text()
                      amountFormatted.replace('$', '').replace /,/g, ''
                      ecardsSent
                      emailsSent
                      tshirtSize
                      teacherName
                      challenge
                    ]
                  $scope.schoolDetailStudents.students = schoolDetailStudents
                  $scope.schoolDetailStudents.downloadData = schoolDetailDownloadData
            response
        $scope.reportPromises.push schoolDetailReportPromise

      console.log $scope.participantGifts
      $scope.toggleNote = ->
        if $scope.participantGift.showMessage is 'false'
          $scope.participantGift.showMessage = 'true'
        else
          $scope.participantGift.showMessage = 'false' 
  ]