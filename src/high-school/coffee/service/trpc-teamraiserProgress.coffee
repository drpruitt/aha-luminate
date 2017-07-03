angular.module 'trPcApp'
  .factory 'NgPcTeamraiserProgressService', [
    'NgPcLuminateRESTService'
    (NgPcLuminateRESTService) ->
      getProgress: ->
        NgPcLuminateRESTService.teamraiserRequest 'method=getParticipantProgress', false, true
          .then (response) ->
            response
  ]