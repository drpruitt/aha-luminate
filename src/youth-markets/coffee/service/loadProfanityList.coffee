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
        url = 'http://heartdev.convio.net/site/PageNavigator/reus_profanity_filter_list.html?pgwrap=n'
      else
        url = 'http://www2.heart.org/site/PageNavigator/reus_profanity_filter_list.html?pgwrap=n'
      $http.get(url, async: false).then (response) ->
        if response.status = 200
          eval response.data
        else
          []

    profanityFactory
]
