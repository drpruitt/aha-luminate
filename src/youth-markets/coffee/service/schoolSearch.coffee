angular.module 'ahaLuminateApp'
  .factory 'SchoolSearchService', [
    '$filter'
    'TeamraiserCompanyService'
    'SchoolLookupService'
    ($filter, TeamraiserCompanyService, SchoolLookupService) ->
      init: ($scope, eventType, getLoc) ->
        $scope.schoolList =
          searchSubmitted: false
          searchPending: false
          searchByLocation: false
          sortProp: 'SCHOOL_NAME'
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
        
        filterGeoSchoolData = (e) ->
          delete $scope.schoolList.schools
          $scope.schoolList.searchPending = true
          $scope.schoolList.searchSubmitted = true
          $scope.schoolList.searchByLocation = true
          SchoolLookupService.getGeoSchoolData e,
            failure: (response) ->
            success: (response) ->
              showSchoolSearchResults(response)

        showGEOError = (e) ->
          switch e.code
            when e.PERMISSION_DENIED
              console.log 'User denied the request for Geolocation.'
            when e.POSITION_UNAVAILABLE
              alert 'Location information is currently unavailable.'
            when e.TIMEOUT
              alert 'The request to get location timed out. Please refresh the page to use this feature.'
            when e.UNKNOWN_ERROR
              alert 'An unknown error occurred.'
          return

        getLocation = ->
          e = 
            enableHighAccuracy: !0
            timeout: 1e4
            maximumAge: 'infinity'
          if navigator.geolocation then navigator.geolocation.getCurrentPosition(filterGeoSchoolData, showGEOError, e) else console.log('Geolocation is not supported by this browser.')
          return

        if getLoc == true
          getLocation()
          
        $scope.getSchoolSearchResultsNew = ->
          delete $scope.schoolList.schools
          $scope.schoolList.searchPending = true
          $scope.schoolList.currentPage = 1
          nameFilter = $scope.schoolList.nameFilter or '%'
          stateFilter = ''
          if $scope.schoolList.stateFilter isnt ''
            stateFilter = $scope.schoolList.stateFilter
          SchoolLookupService.getSchoolDataNew '&name=' + nameFilter + '&state=' + stateFilter,
            failure: (response) ->
            success: (response) ->
              showSchoolSearchResults(response)

        showSchoolSearchResults = (response) ->
              totalNumberResults = 0
              schoolDataRows = response.data.company.schoolData
              schools = []
              angular.forEach schoolDataRows, (schoolDataRow, schoolDataRowIndex) ->
                totalNumberResults++
                schools.push
                  FR_ID: schoolDataRow['fr_id']
                  SCHOOL_NAME: schoolDataRow['name']
                  SCHOOL_ID: schoolDataRow['school_id']
                  COMPANY_ID: schoolDataRow['school_id']
                  SCHOOL_CITY: schoolDataRow['city']
                  SCHOOL_STATE: schoolDataRow['state']
                  COORDINATOR_FIRST_NAME: schoolDataRow['coord_first']
                  COORDINATOR_LAST_NAME: schoolDataRow['coord_last']
              $scope.schoolList.totalNumberResults = totalNumberResults
              $scope.schoolList.totalItems = totalNumberResults
              $scope.schoolList.schools = schools
              #setResults();
              $scope.schoolList.searchSubmitted = true
              delete $scope.schoolList.searchPending
              updateCompanyData()

        $scope.submitSchoolSearchNew = ->
          nameFilter = jQuery.trim $scope.schoolList.ng_nameFilter
          $scope.schoolList.nameFilter = nameFilter
          $scope.schoolList.stateFilter = ''
          $scope.schoolList.searchSubmitted = true
          $scope.schoolList.searchByLocation = false
          # if not nameFilter or nameFilter.length < 3
          if false
            $scope.schoolList.searchErrorMessage = 'Please enter at least 3 characters to search for.'
          else
            delete $scope.schoolList.searchErrorMessage
            $scope.getSchoolSearchResultsNew()

        if getLoc != true 
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

        $scope.submitSchoolSearch = ->
          nameFilter = jQuery.trim $scope.schoolList.ng_nameFilter
          $scope.schoolList.nameFilter = nameFilter
          $scope.schoolList.stateFilter = ''
          $scope.schoolList.searchSubmitted = true
          # if not nameFilter or nameFilter.length < 3
          if false
            $scope.schoolList.searchErrorMessage = 'Please enter at least 3 characters to search for.'
          else
            delete $scope.schoolList.searchErrorMessage
            $scope.getSchoolSearchResults()
        
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
        
        setSchools = (companies) ->
          schools = []
          angular.forEach companies, (company) ->
            if company.coordinatorId and company.coordinatorId isnt '0'
              schools.push
                FR_ID: company.eventId
                COMPANY_ID: company.companyId
                SCHOOL_NAME: company.companyName
                COORDINATOR_ID: company.coordinatorId
          schools
        
        setSchoolsData = (schools) ->
          angular.forEach schools, (school, schoolIndex) ->
            schoolData = $scope.schoolDataMap['id' + school.COMPANY_ID]
            if schoolData
              schools[schoolIndex].SCHOOL_CITY = schoolData.SCHOOL_CITY
              schools[schoolIndex].SCHOOL_STATE = schoolData.SCHOOL_STATE
              schools[schoolIndex].COORDINATOR_FIRST_NAME = schoolData.COORDINATOR_FIRST_NAME
              schools[schoolIndex].COORDINATOR_LAST_NAME = schoolData.COORDINATOR_LAST_NAME
          schools
        
        searchOverridesMap = [
          {
            original: 'Saint', 
            overrides: ['St', 'St.']
          },
          {
            original: 'St', 
            overrides: ['Saint', 'St.']
          },
          {
            original: 'St.', 
            overrides: ['Saint', 'St']
          },
          {
            original: 'and',
            overrides: ['&']
          },
          {
            original: '&',
            overrides: ['and']
          },
          {
            original: 'Ft',
            overrides: ['Fort', 'Ft.']
          },
          {
            original: 'Ft.',
            overrides: ['Fort', 'Ft']
          },
          {
            original: 'Fort',
            overrides: ['Ft', 'Ft.']
          },
          {
            original: 'Mt',
            overrides: ['Mount', 'Mt.']
          },
          {
            original: 'Mt.',
            overrides: ['Mount', 'Mt']
          },
          {
            original: 'Mount',
            overrides: ['Mt', 'Mt.']
          }
        ]
        
        findOverrides = (param) ->
          searchOverridesMap.filter((i) ->
            if param.indexOf(i.original) is -1
              return false
            else
              return true
          )
        
        updateCompanyData = ->
          if not $scope.$$phase
            $scope.$apply()
        
        $scope.getSchoolSearchResults = ->
          delete $scope.schoolList.schools
          $scope.schoolList.searchPending = true
          $scope.schoolList.currentPage = 1
          nameFilter = $scope.schoolList.nameFilter or '%'
          companies = []
          TeamraiserCompanyService.getCompanies 'event_type=' + encodeURIComponent(eventType) + '&company_name=' + encodeURIComponent(nameFilter) + '&list_sort_column=company_name&list_page_size=500', (response) ->
            if response.getCompaniesResponse?.company
              if response.getCompaniesResponse.totalNumberResults is '1'
                companies.push response.getCompaniesResponse.company
              else
                companies = response.getCompaniesResponse.company
            
            totalNumberResults = response.getCompaniesResponse?.totalNumberResults or '0'
            totalNumberResults = Number totalNumberResults
            $scope.schoolList.totalNumberResults = totalNumberResults
            schools = []
            updateCompanyData()

            setResults = ->
              if companies.length > 0
                schools = setSchools companies
                schools = setSchoolsData schools
                $scope.schoolList.totalItems = schools.length
                $scope.schoolList.totalNumberResults = schools.length
                $scope.schoolList.schools = schools
                $scope.orderSchools $scope.schoolList.sortProp, true
                if $scope.schoolList.stateFilter isnt ''
                  schools = $filter('filter') schools, SCHOOL_STATE: $scope.schoolList.stateFilter
                  $scope.schoolList.schools = schools
                  $scope.schoolList.totalItems = schools.length
                  $scope.schoolList.totalNumberResults = schools.length
              else
                $scope.schoolList.schools = []
                $scope.schoolList.totalItems = 0
                $scope.schoolList.totalNumberResults = 0
            
            getAdditionalPages = (filter, totalNumber) ->
              additionalPages = []
              angular.forEach [1, 2, 3], (additionalPage) ->
                if totalNumber > additionalPage * 500
                  additionalPages.push additionalPage
              additionalPagesComplete = 0
              angular.forEach additionalPages, (additionalPage) ->
                TeamraiserCompanyService.getCompanies 'event_type=' + encodeURIComponent(eventType) + '&company_name=' + encodeURIComponent(filter) + '&list_sort_column=company_name&list_page_size=500&list_page_offset=' + additionalPage, (response) ->
                  moreCompanies = response.getCompaniesResponse?.company
                  moreSchools = []
                  if moreCompanies
                    moreCompanies = [moreCompanies] if not angular.isArray moreCompanies
                    if moreCompanies.length > 0
                      moreSchools = setSchools moreCompanies
                      moreSchools = setSchoolsData moreSchools
                      if $scope.schoolList.stateFilter isnt ''
                        moreSchools = $filter('filter') moreSchools, SCHOOL_STATE: $scope.schoolList.stateFilter
                  schools = schools.concat moreSchools
                  additionalPagesComplete++
                  if additionalPagesComplete is additionalPages.length
                    setResults()
                    delete $scope.schoolList.searchPending
                    updateCompanyData()
            
            isOverride = findOverrides nameFilter
            if isOverride.length > 0
              setOverride = (response, nameFilterReplace) ->
                totalNumberOverrides = response.getCompaniesResponse?.totalNumberResults
                
                if response.getCompaniesResponse.totalNumberResults is '1'
                  companies.push response.getCompaniesResponse.company
                else
                  angular.forEach response.getCompaniesResponse?.company, (comp) ->
                    companies.push comp
                totalNumberResults += Number response.getCompaniesResponse?.totalNumberResults
                
                if totalNumberOverrides > 500
                  getAdditionalPages nameFilterReplace, totalNumberOverrides
                else
                  setResults()
                  delete $scope.schoolList.searchPending
                  updateCompanyData()
              
              angular.forEach isOverride, (override) ->
                angular.forEach override.overrides, (replace) ->
                  nameFilterReplace = nameFilter.replace override.original, replace
                  if nameFilterReplace.indexOf('..') is -1
                    TeamraiserCompanyService.getCompanies 'event_type=' + encodeURIComponent(eventType) + '&company_name=' + encodeURIComponent(nameFilterReplace) + '&list_sort_column=company_name&list_page_size=500', (response) ->
                      if response.errorResponse
                        # adding additional call due to occasional error returns
                        # SchoolLookupService.getSchoolCompanies 'company_name=' + encodeURIComponent(nameFilterReplace) + '&list_sort_column=company_name&list_page_size=500'
                          # .then (response) ->
                            # if response.data.errorResponse
                              # console.log 'error'
                            # else
                              # setOverride response, nameFilterReplace
                        angular.noop()
                      else
                        setOverride response, nameFilterReplace
            else
              if totalNumberResults > 500
                getAdditionalPages nameFilter, totalNumberResults
              else
                setResults()
                delete $scope.schoolList.searchPending
                updateCompanyData()
        
  ]
