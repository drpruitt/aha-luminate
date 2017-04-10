angular.module 'trPcApp'
  .directive 'pcBadges', ->
    templateUrl: APP_INFO.rootPath + 'dist/html/participant-center/directive/participantBadges.html'
    restrict: 'E'
    replace: true
    scope:
      contacts: '='
      toggleContact: '='