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
        nameFilter: ''
        ng_nameFilter: ''
        stateFilter: ''
        showHelp: false
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
                  $filter('filter') schools, SCHOOL_NAME: newValue
      
      $scope.submitSchoolSearch = ->
        $scope.schoolList.nameFilter = $scope.schoolList.ng_nameFilter
        $scope.schoolList.stateFilter = ''
        $scope.getSchoolSearchResults()
        $scope.schoolList.searchSubmitted = true
      
      setSchoolsData = (schools) ->
        angular.forEach schools, (school, schoolIndex) ->
          schoolData = $scope.schoolDataMap['id' + school.COMPANY_ID]
          if schoolData
            schools[schoolIndex].SCHOOL_CITY = schoolData.SCHOOL_CITY
            schools[schoolIndex].SCHOOL_STATE = schoolData.SCHOOL_STATE
            schools[schoolIndex].COORDINATOR_FIRST_NAME = schoolData.COORDINATOR_FIRST_NAME
            schools[schoolIndex].COORDINATOR_LAST_NAME = schoolData.COORDINATOR_LAST_NAME
        schools
      
      $scope.getSchoolSearchResults = ->
        delete $scope.schoolList.schools
        $scope.schoolList.searchPending = true
        nameFilter = $scope.schoolList.nameFilter
        SchoolLookupService.getSchoolCompanies 'company_name=' + nameFilter + '&list_sort_column=company_name&list_page_size=500'
          .then (response) ->
            companies = response.data.getCompaniesResponse?.company
            totalNumberResults = response.data.getCompaniesResponse?.totalNumberResults or '0'
            totalNumberResults = Number totalNumberResults
            schools = []
            if companies
              companies = [companies] if not angular.isArray companies
              if companies.length > 0
                schools = setSchools companies
                schools = setSchoolsData schools
                if $scope.schoolList.stateFilter isnt ''
                  schools = $filter('filter') schools, SCHOOL_STATE: $scope.schoolList.stateFilter
            if totalNumberResults <= 500
              $scope.schoolList.totalItems = schools.length
              $scope.schoolList.schools = schools
              $scope.orderSchools $scope.schoolList.sortProp, true
              delete $scope.schoolList.searchPending
            else
              SchoolLookupService.getSchoolCompanies 'company_name=' + nameFilter + '&list_sort_column=company_name&list_page_size=500&list_page_offset=1'
                .then (response) ->
                  companies2 = response.data.getCompaniesResponse?.company
                  schools2 = []
                  if companies2
                    companies2 = [companies2] if not angular.isArray companies2
                    if companies2.length > 0
                      schools2 = setSchools companies2
                      schools2 = setSchoolsData schools2
                      if $scope.schoolList.stateFilter isnt ''
                        schools2 = $filter('filter') schools2, SCHOOL_STATE: $scope.schoolList.stateFilter
                  if totalNumberResults <= 1000
                    $scope.schoolList.totalItems = schools.length
                    $scope.schoolList.schools = schools
                    $scope.orderSchools $scope.schoolList.sortProp, true
                    delete $scope.schoolList.searchPending
                  else
                    SchoolLookupService.getSchoolCompanies 'company_name=' + nameFilter + '&list_sort_column=company_name&list_page_size=500&list_page_offset=2'
                      .then (response) ->
                        companies3 = response.data.getCompaniesResponse?.company
                        schools3 = []
                        if companies3
                          companies3 = [companies3] if not angular.isArray companies3
                          if companies3.length > 0
                            schools3 = setSchools companies3
                            schools3 = setSchoolsData schools3
                            if $scope.schoolList.stateFilter isnt ''
                              schools3 = $filter('filter') schools3, SCHOOL_STATE: $scope.schoolList.stateFilter
                        schools = schools.concat schools3
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