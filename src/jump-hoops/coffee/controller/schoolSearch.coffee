angular.module 'ahaLuminateControllers'
  .controller 'SchoolSearchCtrl', [
    '$rootScope'
    '$scope'
    '$filter'
    'SchoolLookupService'
    'CsvService'
    'UtilsService'
    ($rootScope, $scope, $filter, SchoolLookupService, CsvService, UtilsService) ->
      $scope.states = []
      $scope.schools = []
      $scope.filtered = []
      $scope.schoolList =
        sortProp: 'SCHOOL_STATE'
        sortDesc: true
        totalItems: 0
        currentPage: 1
        numPerPage: 5
        showHelp: false
        typeaheadNoResults: false
        stateFilter: ''
      $scope.schoolCompanyNameCache = {}
      
      $scope.getSchoolCompanies = (newValue) ->
        if newValue.length < 5
          firstTwoCharacters = newValue.substring 0, 2
          if $scope.schoolCompanyNameCache[firstTwoCharacters]
            if $scope.schoolCompanyNameCache[firstTwoCharacters] isnt 'pending'
              $scope.schools = $scope.schoolCompanyNameCache[firstTwoCharacters]
          else
            $scope.schoolCompanyNameCache[firstTwoCharacters] = 'pending'
            SchoolLookupService.getSchoolCompanies 'company_name=' + firstTwoCharacters + '&list_page_size=500'
              .then (response) ->
                companies = response.data.getCompaniesResponse?.company
                if not companies
                  # TODO
                else
                  companies = [companies] if not angular.isArray companies
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
                  $scope.schools = schools
                  $scope.schoolCompanyNameCache[firstTwoCharacters] = schools
                  response.data.schools = schools
                  response.data.schools.map (school) ->
                    school
        else
          firstFiveCharacters = newValue.substring 0, 5
          if $scope.schoolCompanyNameCache[firstFiveCharacters]
            if $scope.schoolCompanyNameCache[firstFiveCharacters] isnt 'pending'
              $scope.schools = $scope.schoolCompanyNameCache[firstFiveCharacters]
          else
            $scope.schoolCompanyNameCache[firstFiveCharacters] = 'pending'
            SchoolLookupService.getSchoolCompanies 'company_name=' + firstFiveCharacters + '&list_page_size=500'
              .then (response) ->
                companies = response.data.getCompaniesResponse?.company
                if not companies
                  # TODO
                else
                  companies = [companies] if not angular.isArray companies
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
                  $scope.schools = schools
                  $scope.schoolCompanyNameCache[firstFiveCharacters] = schools
                  response.data.schools = schools
                  response.data.schools.map (school) ->
                    school
      
      $scope.typeaheadFilter = ->
        $scope.schoolList.stateFilter = ''
        $scope.filterSchools()
      
      $scope.filterSchools = ->
        schools = $scope.schools
        filtered = false
        if schools.length and $scope.schoolList.nameFilter
          filtered = true
          schools = $filter('filter') schools, SCHOOL_NAME: $scope.schoolList.nameFilter, true
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