angular.module 'trPcControllers'
  .controller 'NgPcReportsViewCtrl', [
    '$scope'
    '$filter'
    'NgPcTeamraiserGiftService'
    'NgPcTeamraiserReportsService'
    ($scope, $filter, NgPcTeamraiserGiftService, NgPcTeamraiserReportsService) ->
      $scope.reportPromises = []
      
      $scope.activeReportTab = if $scope.participantRegistration.companyInformation.isCompanyCoordinator is 'true' then 0 else 1
      
      $scope.participantGifts =
        sortColumn: 'date_recorded'
        sortAscending: false
        page: 1
      $scope.getGifts = ->
        pageNumber = $scope.participantGifts.page - 1
        personalGiftsPromise = NgPcTeamraiserGiftService.getGifts 'list_sort_column=' + $scope.participantGifts.sortColumn + '&list_ascending=' + $scope.participantGifts.sortAscending + '&list_page_size=10&list_page_offset=' + pageNumber
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
                  participantGifts.push gift
                $scope.participantGifts.gifts = participantGifts
              $scope.participantGifts.totalNumber = if response.data.getGiftsResponse.totalNumberResults then Number(response.data.getGiftsResponse.totalNumberResults) else 0
            response
        $scope.reportPromises.push personalGiftsPromise
      $scope.getGifts()
      
      if $scope.participantRegistration.aTeamCaptain is 'true'
        $scope.teamGifts =
          sortColumn: 'date_recorded'
          sortAscending: false
          page: 1
        $scope.getTeamGifts = ->
          pageNumber = $scope.teamGifts.page - 1
          personalGiftsPromise = NgPcTeamraiserGiftService.getTeamGifts 'list_sort_column=' + $scope.teamGifts.sortColumn + '&list_ascending=' + $scope.teamGifts.sortAscending + '&list_page_size=10&list_page_offset=' + pageNumber
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
  ]