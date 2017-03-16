angular.module 'ahaLuminateApp'
  .directive 'topCompanyList', ->
    templateUrl: '../[[?xx::x[[S80:dev_branch]]x::::[[S80:dev_branch]]/]]aha-luminate/dist/heart-walk/html/directive/topCompanyList.html'
    restrict: 'E'
    replace: true
    scope:
      companies: '='
      maxSize: '='