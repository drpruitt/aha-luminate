angular.module 'trPcApp'
  .directive 'pcBadges', ->
    templateUrl: '../angular-teamraiser-participant-center/dist/html/directive/participantBadges.html'
    restrict: 'E'
    replace: true
    scope:
      contacts: '='
      toggleContact: '='