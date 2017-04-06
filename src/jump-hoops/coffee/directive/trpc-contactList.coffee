angular.module 'trPcApp'
  .directive 'pcContactList', ->
    templateUrl: '../angular-teamraiser-participant-center/dist/html/directive/contactList.html'
    restrict: 'E'
    replace: true
    scope:
      contacts: '='
      toggleContact: '='
      selectContact: '='
      deleteContact: '='