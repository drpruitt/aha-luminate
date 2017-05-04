angular.module 'trPcApp'
  .directive 'pcImportContactsList', ->
    templateUrl: '../angular-teamraiser-participant-center/dist/html/directive/importContactsList.html'
    restrict: 'E'
    replace: true
    scope:
      contacts: '='
      toggleContact: '='