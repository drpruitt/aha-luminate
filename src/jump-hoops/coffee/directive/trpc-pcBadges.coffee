angular.module 'trPcApp'
  .directive 'pcBadges', ->
    templateUrl: '../html/participant-center/directive/participantBadges.html'
    restrict: 'E'
    replace: true
    scope:
      contacts: '='
      toggleContact: '='