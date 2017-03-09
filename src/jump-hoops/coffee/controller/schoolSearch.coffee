angular.module('ahaLuminateControllers').controller 'SchoolSearchCtrl', [
  '$scope'
  '$rootScope'
  'CsvService'
  'UtilsService'
  'TeamraiserCompanyService'
  ($scope, $rootScope, Csv, Utils, TeamraiserCompanyService) ->
    $scope.states = []
    $scope.schools = []
    $scope.schoolList = {}

    $scope.setStates = ->
      list = {}
      states = []
      states.push
       'id': '?'
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
        i++
        $scope.states = states
        $scope.schoolList.stateFilter = states[0]
      return

    TeamraiserCompanyService.getSchools
      success: (csv) ->
        $scope.schools = Csv.toJson(csv)
        $scope.setStates()
        return
      failure: (response) ->
    return

]