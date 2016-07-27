angular.module 'ahaLuminateApp'
  .directive 'companyTeamList', ->
    templateUrl: '../aha-luminate/dist/heart-walk/html/directive/companyTeamList.html'
    restrict: 'E'
    replace: true
    scope:
      isChildCompany: '='
      companyName: '='
      teams: '='