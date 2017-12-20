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
        $scope.schoolList.searchSubmitted = true
        $scope.schoolList.nameFilter = $scope.schoolList.ng_nameFilter
        $scope.schoolList.stateFilter = ''
        $scope.getSchoolSearchResults()
      
      setSchools = (companies) ->
        schools = []
        angular.forEach companies, (company) ->
          if company.coordinatorId and company.coordinatorId isnt '0'
            schools.push
              FR_ID: company.eventId
              COMPANY_ID: company.companyId
              SCHOOL_NAME: company.companyName
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
          overrides: ['St.']
        },
        {
          original: 'St.', 
          overrides: ['Saint']
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

      $scope.getSchoolSearchResults = ->
        delete $scope.schoolList.schools
        $scope.schoolList.searchPending = true
        nameFilter = $scope.schoolList.nameFilter
        SchoolLookupService.getSchoolCompanies 'company_name=' + encodeURIComponent(nameFilter) + '&list_sort_column=company_name&list_page_size=500'
          .then (response) ->
            companies = response.data.getCompaniesResponse?.company
            totalNumberResults = response.data.getCompaniesResponse?.totalNumberResults or '0'
            totalNumberResults = Number totalNumberResults
            $scope.schoolList.totalNumberResults = totalNumberResults
            schools = []

            setResults = ->
              console.log 'set result'
              if companies
                companies = [companies] if not angular.isArray companies
                if companies.length > 0
                  schools = setSchools companies
                  schools = setSchoolsData schools
                  if $scope.schoolList.stateFilter isnt ''
                    schools = $filter('filter') schools, SCHOOL_STATE: $scope.schoolList.stateFilter

            getAdditionalPages = (filter) -> 
              console.log 'enter get pages'
              additionalPages = []
              angular.forEach [1, 2, 3, 4], (additionalPage) ->
                if totalNumberResults > additionalPage * 500
                  additionalPages.push additionalPage
              additionalPagesComplete = 0
              angular.forEach additionalPages, (additionalPage) ->
                SchoolLookupService.getSchoolCompanies 'company_name=' + encodeURIComponent(filter) + '&list_sort_column=company_name&list_page_size=500&list_page_offset=' + additionalPage
                  .then (response) ->
                    moreCompanies = response.data.getCompaniesResponse?.company
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
                      $scope.schoolList.totalItems = schools.length
                      $scope.schoolList.schools = schools
                      $scope.orderSchools $scope.schoolList.sortProp, true
                      delete $scope.schoolList.searchPending
            isOverride = findOverrides nameFilter
            if isOverride.length is 1
              console.log 'is overide'
              console.log 'total orig' + totalNumberResults
              ###
              if totalNumberResults > 500
                console.log 'orig has more than 500'
                getAdditionalPages nameFilter
              ###
              angular.forEach isOverride[0].overrides, (override) ->
                nameFilterReplace = nameFilter.replace isOverride[0].original, override
                SchoolLookupService.getSchoolCompanies 'company_name=' + encodeURIComponent(nameFilterReplace) + '&list_sort_column=company_name&list_page_size=500'
                  .then (response) ->
                    console.log 'total pre=' +response.data.getCompaniesResponse?.totalNumberResults
                    angular.forEach response.data.getCompaniesResponse?.company, (comp) ->
                      companies.push comp
                    totalNumberResults += Number response.data.getCompaniesResponse?.totalNumberResults
                    
                    console.log 'total post='+totalNumberResults
                    console.log companies
                    
                    setResults()

                    if totalNumberResults <= 500
                      console.log 'is less than 500'
                      $scope.schoolList.totalItems = schools.length
                      $scope.schoolList.schools = schools
                      $scope.orderSchools $scope.schoolList.sortProp, true
                      delete $scope.schoolList.searchPending
                    else
                      console.log 'get more pages of overrides'
                      getAdditionalPages nameFilterReplace
                      
            else
              setResults()
              if totalNumberResults <= 500
                console.log 'less than 500'
                $scope.schoolList.totalItems = schools.length
                $scope.schoolList.schools = schools
                $scope.orderSchools $scope.schoolList.sortProp, true
                delete $scope.schoolList.searchPending
              else
                console.log 'more than 500'
                getAdditionalPages nameFilter
               

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