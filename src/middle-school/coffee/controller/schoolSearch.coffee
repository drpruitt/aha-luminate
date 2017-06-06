angular.module 'ahaLuminateControllers'
  .controller 'SchoolSearchCtrl', [
    '$rootScope'
    '$scope'
    '$filter'
    'SchoolLookupService'
    ($rootScope, $scope, $filter, SchoolLookupService) ->
      $scope.schoolList =
        searchSubmitted: false
        sortProp: 'SCHOOL_STATE'
        sortDesc: true
        totalItems: 0
        currentPage: 1
        numPerPage: 5
        showHelp: false
        stateFilter: ''
      $scope.schoolSuggestionCache = {}
      $scope.schoolResultCache = {}
      
      setSchools = (companies) ->
        schools = []
        angular.forEach companies, (company) ->
          schools.push
            FR_ID: company.eventId
            COMPANY_ID: company.companyId
            SCHOOL_NAME: company.companyName
            SCHOOL_CITY: ""
            SCHOOL_STATE: ""
            COORDINATOR_FIRST_NAME: ""
            COORDINATOR_LAST_NAME: ""
        schools
      
      $scope.getSchoolSuggestions = (newValue) ->
        firstThreeCharacters = newValue.substring 0, 3
        if newValue.length < 6
          if $scope.schoolSuggestionCache[firstThreeCharacters]
            if $scope.schoolSuggestionCache[firstThreeCharacters] isnt 'pending'
              $scope.schoolSuggestionCache[firstThreeCharacters]
          else
            $scope.schoolSuggestionCache[firstThreeCharacters] = 'pending'
            SchoolLookupService.getSchoolCompanies 'company_name=' + firstThreeCharacters + '&list_sort_column=company_name&list_page_size=500'
              .then (response) ->
                companies = response.data.getCompaniesResponse?.company
                schools = []
                if companies
                  companies = [companies] if not angular.isArray companies
                  schools = setSchools companies
                $scope.schoolSuggestionCache[firstThreeCharacters] = schools
        else
          firstSixCharacters = newValue.substring 0, 6
          if newValue.length < 9
            if $scope.schoolSuggestionCache[firstSixCharacters]
              if $scope.schoolSuggestionCache[firstSixCharacters] is 'pending'
                if $scope.schoolSuggestionCache[firstThreeCharacters]
                  if $scope.schoolSuggestionCache[firstThreeCharacters] isnt 'pending'
                    $scope.schoolSuggestionCache[firstThreeCharacters]
              else
                $scope.schoolSuggestionCache[firstSixCharacters]
            else
              $scope.schoolSuggestionCache[firstSixCharacters] = 'pending'
              SchoolLookupService.getSchoolCompanies 'company_name=' + firstSixCharacters + '&list_page_size=500'
                .then (response) ->
                  companies = response.data.getCompaniesResponse?.company
                  schools = []
                  if companies
                    companies = [companies] if not angular.isArray companies
                    schools = setSchools companies
                  $scope.schoolSuggestionCache[firstSixCharacters] = schools
          else
            firstNineCharacters = newValue.substring 0, 9
            if $scope.schoolSuggestionCache[firstNineCharacters]
              if $scope.schoolSuggestionCache[firstNineCharacters] is 'pending'
                if $scope.schoolSuggestionCache[firstSixCharacters]
                  if $scope.schoolSuggestionCache[firstSixCharacters] is 'pending'
                    if $scope.schoolSuggestionCache[firstThreeCharacters]
                      if $scope.schoolSuggestionCache[firstThreeCharacters] isnt 'pending'
                        $scope.schoolSuggestionCache[firstThreeCharacters]
                  else
                    $scope.schoolSuggestionCache[firstSixCharacters]
              else
                $scope.schoolSuggestionCache[firstNineCharacters]
            else
              $scope.schoolSuggestionCache[firstNineCharacters] = 'pending'
              SchoolLookupService.getSchoolCompanies 'company_name=' + firstNineCharacters + '&list_page_size=500'
                .then (response) ->
                  companies = response.data.getCompaniesResponse?.company
                  schools = []
                  if companies
                    companies = [companies] if not angular.isArray companies
                    schools = setSchools companies
                  $scope.schoolSuggestionCache[firstNineCharacters] = schools
      
      $scope.submitSchoolSearch = ->
        $scope.schoolList.stateFilter = ''
        $scope.getSchoolSearchResults()
        $scope.schoolList.searchSubmitted = true
      
      $scope.getSchoolSearchResults = ->
        if $scope.schoolList.schools
          delete $scope.schoolList.schools
        nameFilter = $scope.schoolList.nameFilter
        if $scope.schoolResultCache[nameFilter]
          $scope.schoolList.totalItems = $scope.schoolResultCache[nameFilter].length
          $scope.schoolList.schools = $scope.schoolResultCache[nameFilter]
          $scope.orderSchools $scope.schoolList.sortProp, true
        else
          SchoolLookupService.getSchoolCompanies 'company_name=' + nameFilter + '&list_sort_column=company_name&list_page_size=5'
            .then (response) ->
              companies = response.data.getCompaniesResponse?.company
              if not companies
                $scope.schoolList.totalItems = 0
                $scope.schoolList.schools = []
                $scope.schoolResultCache[nameFilter] = []
              else
                companies = [companies] if not angular.isArray companies
                if companies.length is 0
                  $scope.schoolList.totalItems = 0
                  $scope.schoolList.schools = []
                  $scope.schoolResultCache[nameFilter] = []
                else
                  schools = setSchools companies
                  companyIds = []
                  angular.forEach companies, (company) ->
                    companyIds.push company.companyId
                  SchoolLookupService.getSchoolData companyIds
                    .then (response) ->
                      detailedSchools = response.data.getSchoolSearchDataResponse.school
                      angular.forEach detailedSchools, (detailedSchool) ->
                        angular.forEach schools, (school, schoolIndex) ->
                          if school.COMPANY_ID is detailedSchool.id
                            detailedSchoolData = detailedSchool.schoolData
                            schools[schoolIndex].SCHOOL_CITY = detailedSchoolData[1]
                            schools[schoolIndex].SCHOOL_STATE = detailedSchoolData[2]
                            schools[schoolIndex].COORDINATOR_FIRST_NAME = detailedSchoolData[3]
                            schools[schoolIndex].COORDINATOR_LAST_NAME = detailedSchoolData[4]
                      if $scope.schoolList.stateFilter isnt ''
                        schools = $filter('filter') schools, SCHOOL_STATE: $scope.schoolList.stateFilter
                      $scope.schoolList.totalItems = schools.length
                      $scope.schoolList.schools = schools
                      $scope.orderSchools $scope.schoolList.sortProp, true
                      $scope.schoolResultCache[nameFilter] = schools
      
      $scope.orderSchools = (sortProp, keepSortOrder) ->
        schools = $scope.schoolList.schools
        if schools.length
          if not keepSortOrder
            $scope.schoolList.sortDesc = !$scope.schoolList.sortDesc
          if $scope.schoolList.sortProp isnt sortProp
            $scope.schoolList.sortProp = sortProp
            $scope.schoolList.sortDesc = true
          schools = $filter('orderBy') schools, sortProp, $scope.schoolList.sortDesc
          $scope.schoolList.schools = schools
          $scope.schoolList.currentPage = 1
      
      $scope.paginate = (value) ->
        begin = ($scope.schoolList.currentPage - 1) * $scope.schoolList.numPerPage
        end = begin + $scope.schoolList.numPerPage
        index = $scope.schoolList.schools.indexOf value
        begin <= index and index < end
  ]