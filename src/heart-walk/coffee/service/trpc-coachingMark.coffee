angular.module 'trPcApp'
  .factory 'CoachingMarkService', [
    '$rootScope'
    '$q'
    ($rootScope, $q) ->
      getCoachingMark: ->
        useDeffered = ->
          deferred = $q.defer()
          deferred.resolve $rootScope.coachingMark
          deferred.promise
        if $rootScope.participantRegistration.lastPC2Login is '0'
          $rootScope.coachingMark = 'welcome'
          useDeffered()
        else
          $rootScope.coachingMark = -1
          useDeffered()
  ]