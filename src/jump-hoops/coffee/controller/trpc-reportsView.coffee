angular.module 'trPcControllers'
  .controller 'NgPcReportsViewCtrl', [
    '$scope'
    'NgPcTeamraiserGiftService'
    ($scope, NgPcTeamraiserGiftService) ->
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
              $scope.participantGifts.totalNumber = Number response.data.getGiftsResponse?.totalNumberResults or 0
            response
        $scope.reportPromises.push personalGiftsPromise
      $scope.getGifts()
  ]