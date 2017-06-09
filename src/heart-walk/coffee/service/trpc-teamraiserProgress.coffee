angular.module 'trPcApp'
  .factory 'TeamraiserProgressService', [
    'LuminateRESTService'
    (LuminateRESTService) ->
      getProgress: ->
        LuminateRESTService.teamraiserRequest 'method=getParticipantProgress', false, true
          .then (response) ->
            response
  ]