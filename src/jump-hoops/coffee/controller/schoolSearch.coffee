angular.module('ahaLuminateControllers').controller 'SchoolSearchCtrl', [
  '$scope'
  '$rootScope'
  'CsvService'
  'UtilsService'
  'TeamraiserCompanyService'
  ($scope, $rootScope, Csv, Utils, TeamraiserCompanyService) ->
    $scope.states = []
    $scope.schools = []
    $scope.schoolList =
      sortProp: 'SCHOOL_NAME'
      sortDesc: false
      totalItems: 0
      currentPage: 1
      numPerPage: 5

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

    $scope.paginate = (value) ->
      begin = ($scope.schoolList.currentPage - 1) * $scope.schoolList.numPerPage
      end = begin + $scope.schoolList.numPerPage
      index = $scope.schools.indexOf(value)
      begin <= index and index < end

    TeamraiserCompanyService.getSchools
      success: (csv) ->
        schools = Csv.toJson(csv)
        $scope.schools = schools
        $scope.schoolList.totalItems = schools.length
        $scope.setStates()
        return
      failure: (response) ->
    return

]