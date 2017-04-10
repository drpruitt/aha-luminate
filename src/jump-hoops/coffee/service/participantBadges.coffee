angular.module 'ahaLuminateApp'
  .factory 'ParticipantBadgesService', [
    '$http'
    ($http) ->
      getBadges: ->
        $http
          url: '../ym-dev/mock-badges.json'
  ]