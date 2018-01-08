angular.module 'ahaLuminateControllers'
  .controller 'SchoolSearchCtrl', [
    '$rootScope'
    '$scope'
    'SchoolLookupService'
    'SchoolSearchService'
    ($rootScope, $scope, SchoolLookupService, SchoolSearchService) ->
      SchoolSearchService.init $scope
      
      $scope.checkCreateTeam = (schoolId, frId, coordinatorId)->
        SchoolLookupService.getCreateTeamData '&consId=' + coordinatorId + '&frId=' + frId
          .then (response) ->
            createTeam = response.data.coordinator?.enable_team
            $rootScope.createTeam.schoolName = response.data.coordinator?.company_name
            if createTeam is 'False'
              window.location = luminateExtend.global.path.nonsecure + 'TRR?fr_id=' + frId + '&pg=tfind&fr_tm_opt=existing&s_frTJoin=&company_id=' + schoolId + '&s_frCompanyId=' + schoolId
            else
              $rootScope.createTeam.joinUrl = luminateExtend.global.path.nonsecure + 'TRR?fr_id=' + frId + '&pg=tfind&fr_tm_opt=existing&s_frTJoin=&company_id=' + schoolId + '&s_frCompanyId=' + schoolId
              $rootScope.createTeam.createUrl = luminateExtend.global.path.nonsecure + 'TRR?fr_id=' + frId + '&pg=tfind&fr_tm_opt=new&s_frTJoin=&company_id=' + schoolId + '&s_frCompanyId=' + schoolId
              if not $scope.$$phase
                $scope.$apply()
              angular.element('#createTeamModal').modal()
  ]