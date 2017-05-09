angular.module 'ahaLuminateControllers'
  .controller 'CompanyPageCtrl', [
    '$scope'
    '$rootScope'
    '$location'
    '$filter'
    '$timeout'
    '$uibModal'
    'APP_INFO'
    'TeamraiserCompanyService'
    'TeamraiserTeamService'
    'TeamraiserParticipantService'
    'ZuriService'
    'TeamraiserRegistrationService'
    'TeamraiserCompanyPageService'
    ($scope, $rootScope, $location, $filter, $timeout, $uibModal, APP_INFO, TeamraiserCompanyService, TeamraiserTeamService, TeamraiserParticipantService, ZuriService, TeamraiserRegistrationService, TeamraiserCompanyPageService) ->
      $scope.companyId = $location.absUrl().split('company_id=')[1].split('&')[0]
      domain = $location.absUrl().split('/site')[0]
      $rootScope.companyName = ''
      $scope.companyTeams = []
      $scope.eventDate = ''
      $scope.totalTeams = ''
      $scope.teamId = ''
      $scope.studentsPledgedTotal = ''
      $scope.activity1amt = ''
      $scope.activity2amt = ''
      $scope.activity3amt = ''
      
      ZuriService.getZooSchool $scope.companyId,
        error: (response) ->
          $scope.studentsPledgedTotal = 0
          $scope.activity1amt = 0
          $scope.activity2amt = 0
          $scope.activity3amt = 0
        success: (response) ->
          $scope.studentsPledgedTotal = response.data.studentsPledged
          studentsPledgedActivities = response.data.studentsPledgedByActivity
          if studentsPledgedActivities['1']
            $scope.activity1amt = studentsPledgedActivities['1'].count
          else
            $scope.activity1amt = 0
          if studentsPledgedActivities['2']
            $scope.activity2amt = studentsPledgedActivities['2'].count
          else
            $scope.activity2amt = 0
          if studentsPledgedActivities['3']
            $scope.activity3amt = studentsPledgedActivities['3'].count
          else
            $scope.activity3amt = 0
      
      setCompanyProgress = (amountRaised, goal) ->
        $scope.companyProgress = 
          amountRaised: if amountRaised then Number(amountRaised) else 0
          goal: if goal then Number(goal) else 0
        $scope.companyProgress.amountRaisedFormatted = $filter('currency')($scope.companyProgress.amountRaised / 100, '$').replace '.00', ''
        $scope.companyProgress.goalFormatted = $filter('currency')($scope.companyProgress.goal / 100, '$').replace '.00', ''
        $scope.companyProgress.percent = 0
        if not $scope.$$phase
          $scope.$apply()
        $timeout ->
          percent = $scope.companyProgress.percent
          if $scope.companyProgress.goal isnt 0
            percent = Math.ceil(($scope.companyProgress.amountRaised / $scope.companyProgress.goal) * 100)
          if percent > 100
            percent = 100
          $scope.companyProgress.percent = percent
          if not $scope.$$phase
            $scope.$apply()
        , 500
      
      getCompanyTotals = ->
        TeamraiserCompanyService.getCompanies 'list_page_size=500&company_id=' + $scope.companyId,
          error: ->
            # TODO
          success: (response) ->
            companies = response.getCompaniesResponse.company
            if not companies
              # TODO
            else
              companies = [companies] if not angular.isArray companies
              $scope.participantCount = companies[0].participantCount 
              totalTeams = companies[0].teamCount
              eventId = companies[0].eventId
              amountRaised = companies[0].amountRaised
              goal = companies[0].goal
              name = companies[0].companyName
              coordinatorId = companies[0].coordinatorId
              $rootScope.companyName = name
              setCompanyProgress amountRaised, goal
              
              TeamraiserCompanyService.getCoordinatorQuestion coordinatorId, eventId
                .then (response) ->
                  $scope.eventDate = response.data.coordinator.event_date
                  
                  if totalTeams = 1
                    $scope.teamId = response.data.coordinator.team_id
      getCompanyTotals()
      
      setCompanyTeams = (teams, totalNumber) ->
        $scope.companyTeams.teams = teams or []
        totalNumber = totalNumber or 0
        $scope.companyTeams.totalNumber = Number totalNumber
        $scope.totalTeams = totalNumber
        if not $scope.$$phase
          $scope.$apply()
      
      getCompanyTeams = ->
        TeamraiserTeamService.getTeams 'team_company_id=' + $scope.companyId,
          success: (response) ->
            companyTeams = response.getTeamSearchByInfoResponse.team
            if companyTeams
              companyTeams = [companyTeams] if not angular.isArray companyTeams
              angular.forEach companyTeams, (companyTeam) ->
                companyTeam.amountRaised = Number companyTeam.amountRaised
                companyTeam.amountRaisedFormatted = $filter('currency')(companyTeam.amountRaised / 100, '$').replace '.00', ''
                joinTeamURL = companyTeam.joinTeamURL
                if joinTeamURL
                  companyTeam.joinTeamURL = joinTeamURL.split('/site/')[1]
              totalNumberTeams = response.getTeamSearchByInfoResponse.totalNumberResults
              setCompanyTeams companyTeams, totalNumberTeams
          error: ->
            setCompanyTeams()
      getCompanyTeams()
      
      getCompanyParticipants = ->
        TeamraiserParticipantService.getParticipants 'team_name=' + encodeURIComponent('%%%') + '&first_name=' + encodeURIComponent('%%%') + '&last_name=' + encodeURIComponent('%%%') + '&list_filter_column=team.company_id&list_filter_text=' + $scope.companyId + '&list_sort_column=total&list_ascending=false&list_page_size=50',
            error: ->
              setCompanyParticipants()
              numCompaniesParticipantRequestComplete++
              if numCompaniesParticipantRequestComplete is numCompanies
                setCompanyNumParticipants numParticipants
            success: (response) ->
              participants = response.getParticipantsResponse?.participant
              companyParticipants = []
              totalFundraisers = ''
              if participants
                participants = [participants] if not angular.isArray participants
                angular.forEach participants, (participant) ->
                  if participant.amountRaised > 1
                    participant.amountRaised = Number participant.amountRaised
                    participant.amountRaisedFormatted = $filter('currency')(participant.amountRaised / 100, '$').replace '.00', ''
                    participant.name.last = participant.name.last.substring(0,1)+'.'
                    companyParticipants.push participant
                    totalFundraisers++
              totalNumberParticipants = response.getParticipantsResponse.totalNumberResults
              setCompanyParticipants companyParticipants, totalNumberParticipants, totalFundraisers
      getCompanyParticipants()
      
      if $scope.consId
        TeamraiserRegistrationService.getRegistration
          success: (response) ->
            participantRegistration = response.getRegistrationResponse?.registration
            if participantRegistration
              $scope.participantRegistration = participantRegistration
      
      $scope.companyPagePhoto1 =
        defaultUrl: APP_INFO.rootPath + 'dist/middle-school/image/company-default.jpg'
      
      $scope.editCompanyPhoto1 = ->
        delete $scope.updateCompanyPhoto1Error
        $scope.editCompanyPhoto1Modal = $uibModal.open
          scope: $scope
          templateUrl: APP_INFO.rootPath + 'dist/middle-school/html/modal/editCompanyPhoto1.html'
      
      $scope.closeCompanyPhoto1Modal = ->
        delete $scope.updateCompanyPhoto1Error
        $scope.editCompanyPhoto1Modal.close()
      
      $scope.cancelEditCompanyPhoto1 = ->
        $scope.closeCompanyPhoto1Modal()
      
      $scope.deleteCompanyPhoto1 = (e) ->
        if e
          e.preventDefault()
        angular.element('.js--delete-company-photo-1-form').submit()
        false
      
      window.trPageEdit =
        uploadPhotoError: (response) ->
          errorResponse = response.errorResponse
          photoNumber = errorResponse.photoNumber
          errorCode = errorResponse.code
          errorMessage = errorResponse.message
          
          if photoNumber is '1'
            $scope.updateCompanyPhoto1Error =
              message: errorMessage
          if not $scope.$$phase
            $scope.$apply()
        uploadPhotoSuccess: (response) ->
          delete $scope.updateCompanyPhoto1Error
          if not $scope.$$phase
            $scope.$apply()
          successResponse = response.successResponse
          photoNumber = successResponse.photoNumber
          
          TeamraiserCompanyPageService.getCompanyPhoto
            error: (response) ->
              # TODO
            success: (response) ->
              photoItems = response.getCompanyPhotoResponse?.photoItem
              if photoItems
                photoItems = [photoItems] if not angular.isArray photoItems
                angular.forEach photoItems, (photoItem) ->
                  photoUrl = photoItem.customUrl
                  if photoItem.id is '1'
                    $scope.companyPagePhoto1.customUrl = photoUrl
              if not $scope.$$phase
                $scope.$apply()
              $scope.closeCompanyPhoto1Modal()
      
      $scope.companyPageContent =
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
      
      $scope.editCompanyPageContent = ->
        richText = $scope.companyPageContent.ng_rich_text
        $richText = jQuery '<div />',
          html: richText
        richText = $richText.html()
        richText = richText.replace(/<strong>/g, '<b>').replace(/<strong /g, '<b ').replace /<\/strong>/g, '</b>'
        .replace(/<em>/g, '<i>').replace(/<em /g, '<i ').replace /<\/em>/g, '</i>'
        $scope.companyPageContent.ng_rich_text = richText
        $scope.companyPageContent.mode = 'edit'
        $timeout ->
          angular.element('[ta-bind][contenteditable]').focus()
        , 100

      $scope.resetCompanyPageContent = ->
        $scope.companyPageContent.ng_rich_text = $scope.companyPageContent.rich_text
        $scope.companyPageContent.mode = 'view'
      
      $scope.saveCompanyPageContent = (isRetry) ->
        richText = $scope.companyPageContent.ng_rich_text
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
        TeamraiserCompanyPageService.updateCompanyPageInfo 'rich_text=' + encodeURIComponent(richText),
          error: ->
            # TODO
          success: (response) ->
            if response.teamraiserErrorResponse
              errorCode = response.teamraiserErrorResponse.code
              if errorCode is '2647' and not isRetry
                $scope.companyPageContent.ng_rich_text = response.teamraiserErrorResponse.body
                $scope.savePageContent true
            else
              isSuccess = response.updateCompanyPageResponse?.success is 'true'
              if not isSuccess
                # TODO
              else
                $scope.companyPageContent.rich_text = richText
                $scope.companyPageContent.ng_rich_text = richText
                $scope.companyPageContent.mode = 'view'
                if not $scope.$$phase
                  $scope.$apply()
  ]