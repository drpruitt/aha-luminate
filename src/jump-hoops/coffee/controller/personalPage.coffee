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
        , 100
      
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
                  if photoItem.id is '1'
                    $scope.personalPagePhoto1.customUrl = photoUrl
              $scope.closePersonalPhoto1Modal()
      
      $scope.personalPageContent =
        mode: 'view'
        textEditorToolbar: [
          [
            'bold'
            'italics'
            'underline'
          ]
          [
            'ul'
            'ol'
          ]
          [
            'insertImage'
            'insertLink'
          ]
          [
            'undo'
            'redo'
          ]
        ]
        rich_text: angular.element('.js--default-page-content').html()
        ng_rich_text: angular.element('.js--default-page-content').html()
      
      $scope.editPersonalPageContent = ->
        richText = $scope.personalPageContent.ng_rich_text
        $richText = jQuery '<div />',
          html: richText
        richText = $richText.html()
        richText = richText.replace(/<strong>/g, '<b>').replace(/<strong /g, '<b ').replace /<\/strong>/g, '</b>'
        .replace(/<em>/g, '<i>').replace(/<em /g, '<i ').replace /<\/em>/g, '</i>'
        $scope.personalPageContent.ng_rich_text = richText
        $scope.personalPageContent.mode = 'edit'
        $timeout ->
          angular.element('[ta-bind][contenteditable]').focus()
        , 500
      
      $scope.resetPersonalPageContent = ->
        $scope.personalPageContent.ng_rich_text = $scope.personalPageContent.rich_text
        $scope.personalPageContent.mode = 'view'
      
      $scope.savePersonalPageContent = (isRetry) ->
        richText = $scope.personalPageContent.ng_rich_text
        $richText = jQuery '<div />', 
          html: richText
        richText = $richText.html()
        richText = richText.replace /<\/?[A-Z]+.*?>/g, (m) ->
          m.toLowerCase()
        .replace(/<font>/g, '<span>').replace(/<font /g, '<span ').replace /<\/font>/g, '</span>'
        .replace(/<b>/g, '<strong>').replace(/<b /g, '<strong ').replace /<\/b>/g, '</strong>'
        .replace(/<i>/g, '<em>').replace(/<i /g, '<em ').replace /<\/i>/g, '</em>'
        .replace(/<u>/g, '<span style="text-decoration: underline;">').replace(/<u /g, '<span style="text-decoration: underline;" ').replace /<\/u>/g, '</span>'
        .replace /[\u00A0-\u9999\&]/gm, (i) ->
          '&#' + i.charCodeAt(0) + ';'
        .replace /&#38;/g, '&'
        .replace /<!--[\s\S]*?-->/g, ''
        TeamraiserParticipantPageService.updatePersonalPageInfo 'rich_text=' + encodeURIComponent(richText),
          error: ->
            # TODO
          success: (response) ->
            if response.teamraiserErrorResponse
              errorCode = response.teamraiserErrorResponse.code
              if errorCode is '2647' and not isRetry
                $scope.personalPageContent.ng_rich_text = response.teamraiserErrorResponse.body
                $scope.savePageContent true
            else
              isSuccess = response.updatePersonalPageResponse?.success is 'true'
              if not isSuccess
                # TODO
              else
                $scope.personalPageContent.rich_text = richText
                $scope.personalPageContent.ng_rich_text = richText
                $scope.personalPageContent.mode = 'view'
                if not $scope.$$phase
                  $scope.$apply()
  ]