angular.module 'trPcApp'
  .directive 'pcBadges', ->
    templateUrl: '../jump-hoops-personal/aha-luminate/dist/jump-hoops/html/participant-center/directive/participantBadges.html'
    restrict: 'E'
    replace: true
    scope:
      participantBadge: '='
      participantBadges: '='
    rootScope:
      participantBadge: '='
      participantBadges: '='