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
        url = 'https://secure3.convio.net/heartdev/site/SPageNavigator/reus_profanity_filter_list.html?pgwrap=n'
      else
        url = 'https://www2.heart.org/site/SPageNavigator/reus_profanity_filter_list.html?pgwrap=n'
      $http.get(url, async: false).then (response) ->
        if response.status = 200
          eval response.data
        else
          []

    profanityFactory
]
