angular.module 'ahaLuminateApp'
  .directive 'companyParticipantList', ->
    templateUrl: '../aha-luminate/dist/heart-walk/html/directive/companyParticipantList.html'
    restrict: 'E'
    replace: true
    scope:
      isChildCompany: '='
      companyName: '='
      participants: '='