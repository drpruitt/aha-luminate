angular.module 'ahaLuminateControllers'
  .controller 'SchoolSearchCtrl', [
    '$rootScope'
    '$scope'
    '$filter'
    'CsvService'
    'UtilsService'
    'SchoolService'
    ($rootScope, $scope, $filter, Csv, Utils, SchoolService) ->
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
      
      $scope.setStates = ->
        list = {}
        states = [
          {
            id: '0'
            label: 'Filter Results by State'
          }
        ]
        angular.forEach $scope.schools, (school)
          if school.SCHOOL_STATE and school.SCHOOL_STATE isnt '' and not list[school.SCHOOL_STATE]
            list[school.SCHOOL_STATE] = school.SCHOOL_STATE
            states.push
              id: school.SCHOOL_STATE
              label: school.SCHOOL_STATE
              SCHOOL_STATE: school.SCHOOL_STATE
        $scope.states = states
        $scope.schoolList.stateFilter = states[0]
      
      $scope.typeaheadFilter = ($item, $model, $label, $event) ->
        $scope.schoolList.stateFilter = $scope.states[0]
        $scope.filterSchools()
      
      $scope.filterSchools = ->
        schools = $scope.schools
        filtered = false
        if schools.length and $scope.schoolList.nameFilter
          filtered = true
          schools = $filter('filter') schools, SCHOOL_NAME: $scope.schoolList.nameFilter, true
        if schools.length and $scope.schoolList.stateFilter.SCHOOL_STATE
          filtered = true
          schools = $filter('filter') schools, SCHOOL_STATE: $scope.schoolList.stateFilter.SCHOOL_STATE
        if not filtered
          schools = []
        $scope.schoolList.totalItems = schools.length
        $scope.filtered = schools
        $scope.orderSchools $scope.schoolList.sortProp, true
      
      $scope.orderSchools = (sortProp, keepSortOrder) ->
        schools = $scope.filtered
        if schools.length
          if keepSortOrder
            # OK
          else
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
      
      SchoolService.getSchools
        failure: (response) ->
          return
        success: (csv) ->
          schools = Csv.toJson csv
          $scope.schools = schools
          $scope.setStates()
          return
  ]