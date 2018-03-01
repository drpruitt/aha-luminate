angular.module('ahaLuminateApp').factory 'profanityService', [
  '$http'
  '$rootScope'
  '$sce'
  ($http, $rootScope, $sce) ->
    profanityFactory = {}

    profanityFactory.loadProfanityList = ->
      #return eval("['xx','yy']");}
      url = undefined
      if $rootScope.tablePrefix == 'heartdev'
        url = ((location.protocol == 'https') ? $rootScope.secureDomain : $rootScope.nonSecureDomain)+'/site/SPageNavigator/reus_profanity_filter_list.html?pgwrap=n'
      else
        url = ((location.protocol == 'https') ? $rootScope.secureDomain : $rootScope.nonSecureDomain)+'/site/SPageNavigator/reus_profanity_filter_list.html?pgwrap=n'
      $http.get(url, async: false).then (response) ->
        if response.status = 200
          eval response.data
        else
          []

    profanityFactory
]
