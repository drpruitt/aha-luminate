angular.module('ahaLuminateControllers').controller 'SchoolSearchCtrl', [
  '$scope'
  '$rootScope'
  '$filter'
  'CsvService'
  'UtilsService'
  'SchoolService'
  ($scope, $rootScope, $filter, Csv, Utils, SchoolService) ->
    $scope.states = []
    $scope.schools = []
    $scope.filtered = []
    $scope.schoolList =
      sortProp: 'SCHOOL_NAME'
      sortDesc: false
      totalItems: 0
      currentPage: 1
      numPerPage: 5
      showHelp: false

    $scope.setStates = ->
      list = {}
      states = []
      states.push
        'id': '0'
        'label': 'Filter Results by State'
      schools = $scope.schools
      i = 0
      while i < schools.length
        school = schools[i]
        if school.SCHOOL_STATE and school.SCHOOL_STATE != '' and angular.isUndefined(list[school.SCHOOL_STATE])
          list[school.SCHOOL_STATE] = school.SCHOOL_STATE
          states.push
            'id': school.SCHOOL_STATE
            'label': school.SCHOOL_STATE
            'SCHOOL_STATE': school.SCHOOL_STATE
        i++
        $scope.states = states
        $scope.schoolList.stateFilter = states[0]
      return

    $scope.filterSchools = ->
      filter = $filter 'filter'
      schools = $scope.schools
      filtered = false
      if schools.length and $scope.schoolList.nameFilter
        filtered = true
        schools = filter(schools, SCHOOL_NAME: $scope.schoolList.nameFilter)
      if schools.length and $scope.schoolList.stateFilter.SCHOOL_STATE
        filtered = true
        schools = filter(schools, SCHOOL_STATE: $scope.schoolList.stateFilter.SCHOOL_STATE)
      if filtered is false
        schools = []
      $scope.schoolList.totalItems = schools.length
      $scope.filtered = schools
      $scope.orderSchools $scope.schoolList.sortProp

    $scope.orderSchools = (sortProp) ->
      schools = $scope.filtered
      if schools.length
        orderBy = $filter 'orderBy'
        $scope.schoolList.sortProp = sortProp
        $scope.schoolList.sortDesc = !$scope.schoolList.sortDesc
        schools = orderBy schools, sortProp, $scope.schoolList.sortDesc
        $scope.filtered = schools
        $scope.schoolList.currentPage = 1 # reset pagination back to first page

    $scope.paginate = (value) ->
      begin = ($scope.schoolList.currentPage - 1) * $scope.schoolList.numPerPage
      end = begin + $scope.schoolList.numPerPage
      index = $scope.filtered.indexOf value
      begin <= index and index < end

    SchoolService.getSchools
      success: (csv) ->
        schools = Csv.toJson csv
        $scope.schools = schools
        $scope.setStates()
        return
      failure: (response) ->
        return
]