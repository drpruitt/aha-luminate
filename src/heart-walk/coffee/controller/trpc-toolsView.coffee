angular.module 'trPcControllers'
  .controller 'ToolsViewCtrl', [
    '$scope'
    'PageBuilderService'
    ($scope, PageBuilderService) ->
      PageBuilderService.getPageContent 'reus_heartwalk_participant_center_tools', 'fr_id=' + $scope.frId + '&s_trID=' + $scope.frId
        .then (response) ->
          pageContent = response.data.pageContent
          if pageContent
            $scope.pageContent = pageContent
  ]