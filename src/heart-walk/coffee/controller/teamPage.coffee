angular.module 'ahaLuminateControllers'
  .controller 'TeamPageCtrl', [
    '$scope'
    'TeamraiserParticipantService'
    ($scope, TeamraiserParticipantService) ->
      TeamraiserParticipantService.getParticipants 'list_filter_column=reg.team_id&list_filter_text='
        .then (response) ->
          # TODO
  ]