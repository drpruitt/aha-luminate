angular.module 'ahaLuminateControllers'
  .controller 'SchoolSearchCtrl', [
    '$rootScope'
    '$scope'
    '$filter'
    'SchoolLookupService'
    ($rootScope, $scope, $filter, SchoolLookupService) ->
      $scope.filtered = []
      $scope.schoolList =
        searchSubmitted: false
        sortProp: 'SCHOOL_STATE'
        sortDesc: true
        totalItems: 0
        currentPage: 1
        numPerPage: 5
        showHelp: false
        typeaheadNoResults: false
        stateFilter: ''
      $scope.schoolCompanyNameCache = {}
      
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
          if $scope.schoolCompanyNameCache[firstThreeCharacters]
            if $scope.schoolCompanyNameCache[firstThreeCharacters] isnt 'pending'
              $scope.schoolCompanyNameCache[firstThreeCharacters]
          else
            $scope.schoolCompanyNameCache[firstThreeCharacters] = 'pending'
            SchoolLookupService.getSchoolCompanies 'company_name=' + firstThreeCharacters + '&list_page_size=500'
              .then (response) ->
                companies = response.data.getCompaniesResponse?.company
                schools = []
                if companies
                  companies = [companies] if not angular.isArray companies
                  schools = setSchools companies
                $scope.schoolCompanyNameCache[firstThreeCharacters] = schools
        else
          firstSixCharacters = newValue.substring 0, 6
          if newValue.length < 9
            if $scope.schoolCompanyNameCache[firstSixCharacters]
              if $scope.schoolCompanyNameCache[firstSixCharacters] is 'pending'
                if $scope.schoolCompanyNameCache[firstThreeCharacters]
                  if $scope.schoolCompanyNameCache[firstThreeCharacters] isnt 'pending'
                    $scope.schoolCompanyNameCache[firstThreeCharacters]
              else
                $scope.schoolCompanyNameCache[firstSixCharacters]
            else
              $scope.schoolCompanyNameCache[firstSixCharacters] = 'pending'
              SchoolLookupService.getSchoolCompanies 'company_name=' + firstSixCharacters + '&list_page_size=500'
                .then (response) ->
                  companies = response.data.getCompaniesResponse?.company
                  schools = []
                  if companies
                    companies = [companies] if not angular.isArray companies
                    schools = setSchools companies
                  $scope.schoolCompanyNameCache[firstSixCharacters] = schools
          else
            firstNineCharacters = newValue.substring 0, 9
            if $scope.schoolCompanyNameCache[firstNineCharacters]
              if $scope.schoolCompanyNameCache[firstNineCharacters] is 'pending'
                if $scope.schoolCompanyNameCache[firstSixCharacters]
                  if $scope.schoolCompanyNameCache[firstSixCharacters] is 'pending'
                    if $scope.schoolCompanyNameCache[firstThreeCharacters]
                      if $scope.schoolCompanyNameCache[firstThreeCharacters] isnt 'pending'
                        $scope.schoolCompanyNameCache[firstThreeCharacters]
                  else
                    $scope.schoolCompanyNameCache[firstSixCharacters]
              else
                $scope.schoolCompanyNameCache[firstNineCharacters]
            else
              $scope.schoolCompanyNameCache[firstNineCharacters] = 'pending'
              SchoolLookupService.getSchoolCompanies 'company_name=' + firstNineCharacters + '&list_page_size=500'
                .then (response) ->
                  companies = response.data.getCompaniesResponse?.company
                  schools = []
                  if companies
                    companies = [companies] if not angular.isArray companies
                    schools = setSchools companies
                  $scope.schoolCompanyNameCache[firstNineCharacters] = schools
      
      $scope.submitSchoolSearch = ->
        $scope.schoolList.stateFilter = ''
        $scope.filterSchools()
        $scope.schoolList.searchSubmitted = true
      
      $scope.filterSchools = ->
        SchoolLookupService.getSchoolCompanies 'company_name=' + $scope.schoolList.nameFilter + '&list_page_size=500'
          .then (response) ->
            companies = response.data.getCompaniesResponse?.company
            schools = []
            if companies
              companies = [companies] if not angular.isArray companies
              schools = setSchools companies
            filtered = false
            if schools.length and $scope.schoolList.nameFilter
              filtered = true
              schools = $filter('filter') schools, SCHOOL_NAME: $scope.schoolList.nameFilter
            if schools.length and $scope.schoolList.stateFilter isnt ''
              filtered = true
              schools = $filter('filter') schools, SCHOOL_STATE: $scope.schoolList.stateFilter
            if not filtered
              schools = []
            $scope.schoolList.totalItems = schools.length
            $scope.filtered = schools
            $scope.orderSchools $scope.schoolList.sortProp, true
      
      $scope.orderSchools = (sortProp, keepSortOrder) ->
        schools = $scope.filtered
        if schools.length
          if not keepSortOrder
            $scope.schoolList.sortDesc = !$scope.schoolList.sortDesc
          if $scope.schoolList.sortProp isnt sortProp
            $scope.schoolList.sortProp = sortProp
            $scope.schoolList.sortDesc = true
          schools = $filter('orderBy') schools, sortProp, $scope.schoolList.sortDesc
          $scope.filtered = schools
          $scope.schoolList.currentPage = 1
      
      $scope.paginate = (value) ->
        begin = ($scope.schoolList.currentPage - 1) * $scope.schoolList.numPerPage
        end = begin + $scope.schoolList.numPerPage
        index = $scope.filtered.indexOf value
        begin <= index and index < end
  ]