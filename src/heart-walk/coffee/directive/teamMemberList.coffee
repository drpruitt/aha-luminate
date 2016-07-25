angular.module 'ahaLuminateApp'
  .directive 'teamMemberList', ->
    templateUrl: '../aha-luminate/dist/heart-walk/html/directive/teamMemberList.html'
    restrict: 'E'
    replace: true
    scope:
      teamMembers: '='