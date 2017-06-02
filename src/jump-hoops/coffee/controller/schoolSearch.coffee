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
      sortProp: 'SCHOOL_STATE'
      sortDesc: true
      totalItems: 0
      currentPage: 1
      numPerPage: 5
      showHelp: false
      typeaheadNoResults: false

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
        if school.SCHOOL_STATE and school.SCHOOL_STATE isnt '' and angular.isUndefined(list[school.SCHOOL_STATE])
          list[school.SCHOOL_STATE] = school.SCHOOL_STATE
          states.push
            'id': school.SCHOOL_STATE
            'label': school.SCHOOL_STATE
            'SCHOOL_STATE': school.SCHOOL_STATE
        i++
      $scope.states = states
      $scope.schoolList.stateFilter = states[0]

    $scope.typeaheadFilter = ($item, $model, $label, $event) ->
      $scope.schoolList.stateFilter = $scope.states[0]
      $scope.filterSchools()

    $scope.filterSchools = ->
      filter = $filter 'filter'
      schools = $scope.schools
      filtered = false
      if schools.length and $scope.schoolList.nameFilter
        filtered = true
        schools = filter(schools, SCHOOL_NAME: $scope.schoolList.nameFilter, true)
      if schools.length and $scope.schoolList.stateFilter.SCHOOL_STATE
        filtered = true
        schools = filter(schools, SCHOOL_STATE: $scope.schoolList.stateFilter.SCHOOL_STATE)
      if filtered is false
        schools = []
      $scope.schoolList.totalItems = schools.length
      $scope.filtered = schools
      $scope.orderSchools $scope.schoolList.sortProp, true

    $scope.orderSchools = (sortProp, keepSortOrder) ->
      schools = $scope.filtered
      if schools.length
        orderBy = $filter 'orderBy'
        if keepSortOrder
          # OK
        else
          $scope.schoolList.sortDesc = !$scope.schoolList.sortDesc
        if $scope.schoolList.sortProp isnt sortProp
          $scope.schoolList.sortProp = sortProp
          $scope.schoolList.sortDesc = true
        schools = orderBy schools, sortProp, $scope.schoolList.sortDesc
        $scope.filtered = schools
        $scope.schoolList.currentPage = 1 # reset pagination back to first page

    $scope.paginate = (value) ->
      begin = ($scope.schoolList.currentPage - 1) * $scope.schoolList.numPerPage
      end = begin + $scope.schoolList.numPerPage
      index = $scope.filtered.indexOf value
      begin <= index and index < end

    SchoolService.getSchools
      failure: (response) ->
        console.log response
        return
      success: (csv) ->
        console.log 'test'

        schools = Csv.toJson csv
        console.log schools
        $scope.schools = schools
        $scope.setStates()
        return
]
