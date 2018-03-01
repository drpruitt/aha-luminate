angular.module('ahaLuminateApp').factory 'profanityService', [
  '$http'
  '$rootScope'
  '$sce'
  ($http, $rootScope, $sce) ->
    profanityFactory = {}

    profanityFactory.loadProfanityList = ->
      url = (if location.protocol == 'https:' then $rootScope.secureDomain + 'site/SPageNavigator' else $rootScope.nonSecureDomain + 'site/PageNavigator') + '/reus_profanity_filter_list.html?pgwrap=n'
      $http.get(url, async: false).then (response) ->
        if response.status = 200
          eval response.data
        else
          []

    profanityFactory
]
