angular.module 'ahaLuminateApp'
  .directive 'topCompanyList', ->
    templateUrl: '../aha-luminate/dist/heart-walk/html/directive/topCompanyList.html'
    restrict: 'E'
    replace: true
    scope:
      companies: '='
      maxSize: '='