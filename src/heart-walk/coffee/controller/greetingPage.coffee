angular.module 'ahaLuminateControllers'
  .controller 'GreetingPageCtrl', [
    '$scope'
    '$http'
    '$timeout'
    '$filter'
    'TeamraiserParticipantService'
    'TeamraiserTeamService'
    'TeamraiserCompanyDataService'
    ($scope, $http, $timeout, $filter, TeamraiserParticipantService, TeamraiserTeamService, TeamraiserCompanyDataService) ->
      $http.get 'PageServer?pagename=getTeamraiserInfo&fr_id=' + $scope.frId + '&response_format=json&pgwrap=n'
        .then (response) ->
          teamraiserInfo = response.data.getTeamraiserInfo
          if not teamraiserInfo
            $scope.eventProgress = 
              amountRaised: 0
              goal: 0
          else
            $scope.eventProgress = 
              amountRaised: teamraiserInfo.amountRaised
              goal: teamraiserInfo.goal
          $scope.eventProgress.percent = 2
          $timeout ->
            percent = $scope.eventProgress.percent
            if $scope.eventProgress.goal isnt 0
              percent = Math.ceil(($scope.eventProgress.amountRaised / $scope.eventProgress.goal) * 100)
            if percent < 2
              percent = 2
            if percent > 98
              percent = 98
            $scope.eventProgress.percent = percent
          , 500
      
      $scope.topParticipants = {}
      setTopParticipants = (participants) ->
        $scope.topParticipants.participants = participants
        if not $scope.$$phase
          $scope.$apply()
      TeamraiserParticipantService.getParticipants 'first_name=' + encodeURIComponent('%%%') + '&list_sort_column=total&list_ascending=false', 
        error: () ->
          setTopParticipants []
        success: (response) ->
          participants = response.getParticipantsResponse?.participant or []
          if not participants
            setTopParticipants []
          else
            participants = [participants] if not angular.isArray participants
            topParticipants = []
            # TODO: don't include participants with $0 raised
            angular.forEach participants, (participant) ->
              if participant.name?.first
                participant.amountRaised = Number participant.amountRaised
                participant.amountRaisedFormatted = $filter('currency')(participant.amountRaised / 100, '$').replace '.00', ''
                topParticipants.push participant
            setTopParticipants topParticipants
      
      $scope.topTeams = {}
      setTopTeams = (teams) ->
        $scope.topTeams.teams = teams
        if not $scope.$$phase
          $scope.$apply()
      TeamraiserTeamService.getTeams 'list_sort_column=total&list_ascending=false', 
        error: () ->
          setTopTeams []
        success: (response) ->
          teams = response.getTeamSearchByInfoResponse?.team or []
          if not teams
            setTopTeams []
          else
            teams = [teams] if not angular.isArray teams
            topTeams = []
            # TODO: don't include teams with $0 raised
            angular.forEach teams, (team) ->
              team.amountRaised = Number team.amountRaised
              team.amountRaisedFormatted = $filter('currency')(team.amountRaised / 100, '$').replace '.00', ''
              topTeams.push team
            setTopTeams topTeams
      
      $scope.topCompanies = {}
      TeamraiserCompanyDataService.getCompanyData()
        .then (response) ->
          companies = response.data.getCompanyDataResponse?.company
          if not companies
            $scope.topCompanies.companies = []
          else
            topCompanies = []
            csvToArray = (strData) ->
              strDelimiter = ','
              objPattern = new RegExp ("(\\" + strDelimiter + "|\\r?\\n|\\r|^)" + "(?:\"([^\"]*(?:\"\"[^\"]*)*)\"|" + "([^\"\\" + strDelimiter + "\\r\\n]*))"), "gi"
              arrData = [[]]
              arrMatches = null
              while arrMatches = objPattern.exec(strData)
                strMatchedDelimiter = arrMatches[1]
                strMatchedValue = undefined
                if strMatchedDelimiter.length and strMatchedDelimiter isnt strDelimiter
                  arrData.push []
                if arrMatches[2]
                  strMatchedValue = arrMatches[2].replace new RegExp("\"\"", "g"), "\""
                else
                  strMatchedValue = arrMatches[3]
                arrData[arrData.length - 1].push strMatchedValue
              arrData
            # TODO: don't include companies with $0 raised
            angular.forEach companies, (company) ->
              if company isnt ''
                companyData = csvToArray company
                topCompanies.push
                  "eventId": $scope.frId
                  "companyId": companyData[0]
                  "participantCount": companyData[3]
                  "companyName": companyData[1]
                  "teamCount": companyData[4]
                  "amountRaised": Number companyData[2]
                  "amountRaisedFormatted": $filter('currency')(Number(companyData[2]) / 100, '$').replace '.00', ''
            # TODO: sort topCompanies by amount raised
            $scope.topCompanies.companies = topCompanies
  ]