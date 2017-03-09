angular.module 'ahaLuminateApp'
  .directive 'schoolList', ->
    templateUrl: 'http://www2.heart.org/aha-luminate/dist/jump-hoops/html/directive/schoolList.html'
    restrict: 'E'
    replace: true
    require: 'ngModel'
    scope:
      schools: '='
      nameFilter: '='
      stateFilter: '='
