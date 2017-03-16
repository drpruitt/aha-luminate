angular.module 'ahaLuminateApp'
  .directive 'topParticipantList', ->
    templateUrl: '../[[?xx::x[[S80:dev_branch]]x::::[[S80:dev_branch]]/]]aha-luminate/dist/heart-walk/html/directive/topParticipantList.html'
    restrict: 'E'
    replace: true
    scope:
      participants: '='
      maxSize: '='