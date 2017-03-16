angular.module 'ahaLuminateApp'
  .directive 'teamMemberList', ->
    templateUrl: '../[[?xx::x[[S80:dev_branch]]x::::[[S80:dev_branch]]/]]aha-luminate/dist/heart-walk/html/directive/teamMemberList.html'
    restrict: 'E'
    replace: true
    scope:
      teamMembers: '='
      teamGiftsLabel: '='
      teamGiftsAmount: '='
      teamGiftsAmountFormatted: '='