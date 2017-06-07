angular.module 'ahaLuminateControllers'
  .controller 'SchoolSearchCtrl', [
    '$rootScope'
    '$scope'
    '$filter'
    'SchoolLookupService'
    ($rootScope, $scope, $filter, SchoolLookupService) ->
      $scope.schoolList =
        searchSubmitted: false
        searchPending: false
        sortProp: 'SCHOOL_STATE'
        sortDesc: false
        totalItems: 0
        currentPage: 1
        paginationItemsPerPage: 5
        paginationMaxSize: 5
        showHelp: false
        stateFilter: ''
      $scope.schoolDataMap = {}
      $scope.schoolSuggestionCache = {}
      
      SchoolLookupService.getSchoolData()
        .then (response) ->
          schoolDataRows = response.data.getSchoolSearchDataResponse.schoolData
          schoolDataHeaders = {}
          schoolDataMap = {}
          angular.forEach schoolDataRows[0], (schoolDataHeader, schoolDataHeaderIndex) ->
            schoolDataHeaders[schoolDataHeader] = schoolDataHeaderIndex
          angular.forEach schoolDataRows, (schoolDataRow, schoolDataRowIndex) ->
            if schoolDataRowIndex > 0
              schoolDataMap['id' + schoolDataRow[schoolDataHeaders.COMPANY_ID]] =
                SCHOOL_CITY: schoolDataRow[schoolDataHeaders.SCHOOL_CITY]
                SCHOOL_STATE: schoolDataRow[schoolDataHeaders.SCHOOL_STATE]
                COORDINATOR_FIRST_NAME: schoolDataRow[schoolDataHeaders.COORDINATOR_FIRST_NAME]
                COORDINATOR_LAST_NAME: schoolDataRow[schoolDataHeaders.COORDINATOR_LAST_NAME]
          $scope.schoolDataMap = schoolDataMap
          if $scope.schoolList.schools?.length > 0
            angular.forEach $scope.schoolList.schools, (school, schoolIndex) ->
              schoolData = $scope.schoolDataMap['id' + school.COMPANY_ID]
              if schoolData
                school.SCHOOL_CITY = schoolData.SCHOOL_CITY
                school.SCHOOL_STATE = schoolData.SCHOOL_STATE
                school.COORDINATOR_FIRST_NAME = schoolData.COORDINATOR_FIRST_NAME
                school.COORDINATOR_LAST_NAME = schoolData.COORDINATOR_LAST_NAME
                $scope.schoolList.schools[schoolIndex] = school
      
      setSchools = (companies) ->
        schools = []
        angular.forEach companies, (company) ->
          schools.push
            FR_ID: company.eventId
            COMPANY_ID: company.companyId
            SCHOOL_NAME: company.companyName
        schools
      
      $scope.getSchoolSuggestions = (newValue) ->
        firstThreeCharacters = newValue.substring 0, 3
        if $scope.schoolSuggestionCache[firstThreeCharacters] and $scope.schoolSuggestionCache[firstThreeCharacters] isnt 'pending' and (newValue.length < 6 or $scope.schoolSuggestionCache[firstThreeCharacters].length < 500)
          $filter('filter') $scope.schoolSuggestionCache[firstThreeCharacters], SCHOOL_NAME: newValue
        else
          firstSixCharacters = newValue.substring 0, 6
          if $scope.schoolSuggestionCache[firstSixCharacters] and $scope.schoolSuggestionCache[firstSixCharacters] isnt 'pending' and (newValue.length < 9 or $scope.schoolSuggestionCache[firstSixCharacters].length < 500)
            $filter('filter') $scope.schoolSuggestionCache[firstSixCharacters], SCHOOL_NAME: newValue
          else
            firstNineCharacters = newValue.substring 0, 9
            if $scope.schoolSuggestionCache[firstNineCharacters] and $scope.schoolSuggestionCache[firstNineCharacters] isnt 'pending'
              $filter('filter') $scope.schoolSuggestionCache[firstNineCharacters], SCHOOL_NAME: newValue
            else
              searchCharacters = firstThreeCharacters
              if newValue.length > 5
                searchCharacters = firstSixCharacters
              if newValue.length > 8
                searchCharacters = firstNineCharacters
              $scope.schoolSuggestionCache[searchCharacters] = 'pending'
              SchoolLookupService.getSchoolCompanies 'company_name=' + searchCharacters + '&list_sort_column=company_name&list_page_size=500'
                .then (response) ->
                  companies = response.data.getCompaniesResponse?.company
                  schools = []
                  if companies
                    companies = [companies] if not angular.isArray companies
                    schools = setSchools companies
                  schools = $filter('unique') schools, 'SCHOOL_NAME'
                  $scope.schoolSuggestionCache[searchCharacters] = schools
                  $filter('filter') $scope.schoolSuggestionCache[searchCharacters], SCHOOL_NAME: newValue
      
      $scope.submitSchoolSearch = ->
        $scope.schoolList.nameFilter = $scope.schoolList.ng_nameFilter
        $scope.schoolList.stateFilter = ''
        $scope.getSchoolSearchResults()
        $scope.schoolList.searchSubmitted = true
      
      $scope.getSchoolSearchResults = ->
        delete $scope.schoolList.schools
        $scope.schoolList.searchPending = true
        SchoolLookupService.getSchoolCompanies 'company_name=' + $scope.schoolList.nameFilter + '&list_sort_column=company_name&list_page_size=500'
          .then (response) ->
            companies = response.data.getCompaniesResponse?.company
            if not companies
              $scope.schoolList.totalItems = 0
              $scope.schoolList.schools = []
              delete $scope.schoolList.searchPending
            else
              companies = [companies] if not angular.isArray companies
              if companies.length is 0
                $scope.schoolList.totalItems = 0
                $scope.schoolList.schools = []
                delete $scope.schoolList.searchPending
              else
                schools = setSchools companies
                angular.forEach schools, (school) ->
                  schoolData = $scope.schoolDataMap['id' + school.COMPANY_ID]
                  if schoolData
                    school.SCHOOL_CITY = schoolData.SCHOOL_CITY
                    school.SCHOOL_STATE = schoolData.SCHOOL_STATE
                    school.COORDINATOR_FIRST_NAME = schoolData.COORDINATOR_FIRST_NAME
                    school.COORDINATOR_LAST_NAME = schoolData.COORDINATOR_LAST_NAME
                if $scope.schoolList.stateFilter isnt ''
                  schools = $filter('filter') schools, SCHOOL_STATE: $scope.schoolList.stateFilter
                $scope.schoolList.totalItems = schools.length
                $scope.schoolList.schools = schools
                $scope.orderSchools $scope.schoolList.sortProp, true
                delete $scope.schoolList.searchPending
      
      $scope.orderSchools = (sortProp, keepSortOrder) ->
        schools = $scope.schoolList.schools
        if schools.length > 0
          if not keepSortOrder
            $scope.schoolList.sortDesc = !$scope.schoolList.sortDesc
          if $scope.schoolList.sortProp isnt sortProp
            $scope.schoolList.sortProp = sortProp
            $scope.schoolList.sortDesc = true
          schools = $filter('orderBy') schools, sortProp, $scope.schoolList.sortDesc
          $scope.schoolList.schools = schools
          $scope.schoolList.currentPage = 1
      
      $scope.paginate = (value) ->
        begin = ($scope.schoolList.currentPage - 1) * $scope.schoolList.paginationItemsPerPage
        end = begin + $scope.schoolList.paginationItemsPerPage
        index = $scope.schoolList.schools.indexOf value
        begin <= index and index < end
  ]