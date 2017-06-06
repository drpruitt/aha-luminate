angular.module 'ahaLuminateControllers'
  .controller 'SchoolSearchCtrl', [
    '$rootScope'
    '$scope'
    '$filter'
    'TeamraiserCompanyService'
    'CsvService'
    'UtilsService'
    'SchoolLookupService'
    ($rootScope, $scope, $filter, TeamraiserCompanyService, CsvService, UtilsService, SchoolLookupService) ->
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
      
      $scope.$watch 'schoolList.nameFilter', (newValue) ->
        if newValue and newValue isnt '' and newValue.length > 2
          firstThreeCharacters = newValue.substring 0, 3
          if $scope.schoolCompanyNameCache[firstThreeCharacters]
            if $scope.schoolCompanyNameCache[firstThreeCharacters] isnt 'pending'
              $scope.schools = $scope.schoolCompanyNameCache[firstThreeCharacters]
          else
            $scope.schoolCompanyNameCache[firstThreeCharacters] = 'pending'
            TeamraiserCompanyService.getCompanies 'company_name=' + newValue + '&list_page_size=500',
              error: ->
                # TODO
              success: (response) ->
                companies = response.getCompaniesResponse?.company
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
                  $scope.schools = $scope.schoolCompanyNameCache[firstThreeCharacters]
                  $scope.schoolCompanyNameCache[firstThreeCharacters] = companies
      
      $scope.typeaheadFilter = ($item, $model, $label, $event) ->
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
      
      SchoolLookupService.getSchools
        failure: (response) ->
          return
        success: (csv) ->
          schools = CsvService.toJson csv
          $scope.schools = schools
          return
  ]