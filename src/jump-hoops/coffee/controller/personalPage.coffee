angular.module 'ahaLuminateControllers'
  .controller 'PersonalPageCtrl', [
    '$scope'
    '$rootScope'
    '$location'
    '$filter'
    '$timeout'
    '$uibModal'
    'APP_INFO'
    'TeamraiserParticipantService'
    'TeamraiserCompanyService'
    'ZuriService'
    'ParticipantBadgesService'
    'TeamraiserParticipantPageService'
    ($scope, $rootScope, $location, $filter, $timeout, $uibModal, APP_INFO, TeamraiserParticipantService, TeamraiserCompanyService, ZuriService, ParticipantBadgesService, TeamraiserParticipantPageService) ->
      $dataRoot = angular.element '[data-aha-luminate-root]'
      $scope.participantId = $location.absUrl().split('px=')[1].split('&')[0]
      frId = $dataRoot.data('fr-id') if $dataRoot.data('fr-id') isnt ''
      $scope.companyId = $dataRoot.data('company-id') if $dataRoot.data('company-id') isnt ''
      $scope.teamId = $dataRoot.data('team-id') if $dataRoot.data('team-id') isnt ''
      $scope.eventDate =''
      $rootScope.numTeams = ''
      $scope.challengeId = null
      $scope.challengeName = null
      $scope.challengeCompleted = 0
      
      $scope.prizes = []
      ParticipantBadgesService.getBadges '3196745'
      .then (response) ->
        if not response.data.status or response.data.status isnt 'success'
          # TODO
        else
          prizes = response.data.prizes
          angular.forEach prizes, (prize) ->
            if prize.earned_datetime isnt null
              $scope.prizes.push
                id: prize.id
                label: prize.label
                sku: prize.sku
                status: prize.status
                earned: prize.earned_datetime
      
      ZuriService.getZooStudent frId + '/' + $scope.participantId,
        error: (response) ->
          $scope.challengeName = null
          $scope.challengeId = null
          $scope.challengeCompleted = 0
        success: (response) ->
          $scope.challengeId = response.data.challenges.current
          $scope.challengeName = response.data.challenges.text
          $scope.challengeCompleted = response.data.challenges.completed
      
      TeamraiserCompanyService.getCompanies 'company_id=' + $scope.companyId,
        success: (response) ->
          coordinatorId = response.getCompaniesResponse?.company.coordinatorId
          eventId = response.getCompaniesResponse?.company.eventId
          $rootScope.numTeams = response.getCompaniesResponse.company.teamCount
          
          TeamraiserCompanyService.getCoordinatorQuestion coordinatorId, eventId
            .then (response) ->
              $scope.eventDate = response.data.coordinator.event_date
        
      setParticipantProgress = (amountRaised, goal) ->
        $scope.personalProgress = 
          amountRaised: if amountRaised then Number(amountRaised) else 0
          goal: if goal then Number(goal) else 0
        $scope.personalProgress.amountRaisedFormatted = $filter('currency')($scope.personalProgress.amountRaised / 100, '$').replace '.00', ''
        $scope.personalProgress.goalFormatted = $filter('currency')($scope.personalProgress.goal / 100, '$').replace '.00', ''
        $scope.personalProgress.percent = 0
        if not $scope.$$phase
          $scope.$apply()
        $timeout ->
          percent = $scope.personalProgress.percent
          if $scope.personalProgress.goal isnt 0
            percent = Math.ceil(($scope.personalProgress.amountRaised / $scope.personalProgress.goal) * 100)
          if percent > 100
            percent = 100
          $scope.personalProgress.percent = percent
          if not $scope.$$phase
            $scope.$apply()
        , 500
      
      TeamraiserParticipantService.getParticipants 'fr_id=' + $scope.frId + '&first_name=' + encodeURIComponent('%%') + '&last_name=' + encodeURIComponent('%') + '&list_filter_column=reg.cons_id&list_filter_text=' + $scope.participantId, 
        error: ->
          setParticipantProgress()
        success: (response) ->
          participantInfo = response.getParticipantsResponse?.participant
          if not participantInfo
            setParticipantProgress()
          else
            setParticipantProgress Number(participantInfo.amountRaised), Number(participantInfo.goal)
      
      $scope.personalDonors = 
        page: 1
      $defaultResponsivePersonalDonors = angular.element '.js--personal-donors .team-honor-list-row'
      if $defaultResponsivePersonalDonors and $defaultResponsivePersonalDonors.length isnt 0
        if $defaultResponsivePersonalDonors.length is 1 and $defaultResponsivePersonalDonors.eq(0).find('.team-honor-list-name').length is 0
          $scope.personalDonors.donors = []
          $scope.personalDonors.totalNumber = 0
        else
          angular.forEach $defaultResponsivePersonalDonors, (personalDonor, personalDonorIndex) ->
            donorName = angular.element(personalDonor).find('.team-honor-list-name').text()
            donorAmount = angular.element(personalDonor).find('.team-honor-list-value').text()
            if not donorAmount or donorAmount.indexOf('$') is -1
              donorAmount = -1
            else
              donorAmount = Number(donorAmount.replace('$', '').replace(/,/g, '')) * 100
            if not $scope.personalDonors.donors
              $scope.personalDonors.donors = []
            $scope.personalDonors.donors.push 
              name: donorName
              amount: donorAmount
              amountFormatted: if donorAmount is -1 then '' else $filter('currency')(donorAmount / 100, '$').replace '.00', ''
          $scope.personalDonors.totalNumber = $defaultResponsivePersonalDonors.length
      else
        $defaultPersonalDonors = angular.element '.js--personal-donors .scrollContent p'
        if not $defaultPersonalDonors or $defaultPersonalDonors.length is 0
          $scope.personalDonors.donors = []
          $scope.personalDonors.totalNumber = 0
        else
          angular.forEach $defaultPersonalDonors, (personalDonor, personalDonorIndex) ->
            donorName = jQuery.trim angular.element(personalDonor).html().split('<')[0]
            donorAmount = jQuery.trim angular.element(personalDonor).html().split('>')[1]
            if not donorAmount or donorAmount.indexOf('$') is -1
              donorAmount = -1
            else
              donorAmount = Number(donorAmount.replace('$', '').replace(/,/g, '')) * 100
            if not $scope.personalDonors.donors
              $scope.personalDonors.donors = []
            $scope.personalDonors.donors.push 
              name: donorName
              amount: donorAmount
              amountFormatted: if donorAmount is -1 then '' else $filter('currency')(donorAmount / 100, '$').replace '.00', ''
          $scope.personalDonors.totalNumber = $defaultPersonalDonors.length
      
      $scope.personalPagePhoto1 =
        defaultUrl: APP_INFO.rootPath + 'dist/jump-hoops/image/personal-default.jpg'
      
      $scope.personalPhoto1IsDefault = true
      
      $scope.editPersonalPhoto1 = ->
        $scope.editPersonalPhoto1Modal = $uibModal.open
          scope: $scope
          templateUrl: APP_INFO.rootPath + 'dist/jump-hoops/html/modal/editPersonalPhoto1.html'
      
      $scope.closePersonalPhoto1Modal = ->
        $scope.editPersonalPhoto1Modal.close()
      
      $scope.cancelEditPersonalPhoto1 = ->
        $scope.closePersonalPhoto1Modal()
      
      $scope.deletePersonalPhoto1 = (e) ->
        if e
          e.preventDefault()
        # TODO
      
      window.trPageEdit =
        uploadPhotoError: (response) ->
          errorResponse = response.errorResponse
          photoType = errorResponse.photoType
          photoNumber = errorResponse.photoNumber
          errorCode = errorResponse.code
          errorMessage = errorResponse.message
          
          # if photoNumber is '1'
            # TODO
        uploadPhotoSuccess: (response) ->
          successResponse = response.successResponse
          photoType = successResponse.photoType
          photoNumber = successResponse.photoNumber
          
          TeamraiserParticipantPageService.getPersonalPhotos
            error: (response) ->
              # TODO
            success: (response) ->
              photoItems = response.getPersonalPhotosResponse?.photoItem
              if photoItems
                photoItems = [photoItems] if not angular.isArray photoItems
                angular.forEach photoItems, (photoItem) ->
                  photoUrl = photoItem.customUrl
                  # if photoItem.id is '1'
                    # TODO
              $scope.closePersonalPhoto1Modal()
      
      $scope.personalPageContent =
        mode: 'view'
  ]