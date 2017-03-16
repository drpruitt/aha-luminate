angular.module 'ahaLuminateApp'
  .directive 'topParticipantList', ->
    templateUrl: '../aha-luminate/dist/heart-walk/html/directive/topParticipantList.html'
    restrict: 'E'
    replace: true
    scope:
      participants: '='
      maxSize: '='