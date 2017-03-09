angular.module 'ahaLuminateApp'
  .directive 'schoolList', ->
    templateUrl: '../aha-luminate/dist/jump-hoops/html/directive/schoolList.html'
    restrict: 'E'
    replace: true
    require: 'ngModel'
    scope:
      schools: '='
      nameFilter: '='
      stateFilter: '='
