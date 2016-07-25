angular.module 'ahaLuminateControllers'
  .controller 'TeamPageCtrl', [
    '$scope'
    'TeamraiserParticipantService'
    ($scope, TeamraiserParticipantService) ->
      TeamraiserParticipantService.getParticipants 'team_id='
        .then (response) ->
          # TODO
  ]