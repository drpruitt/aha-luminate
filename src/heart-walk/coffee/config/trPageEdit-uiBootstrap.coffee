angular.module 'trPageEditApp'
  .config [
    '$uibModalProvider'
    ($uibModalProvider) ->
      angular.extend $uibModalProvider.options, 
        windowClass: 'ng-tr-pg-edit-modal'
  ]