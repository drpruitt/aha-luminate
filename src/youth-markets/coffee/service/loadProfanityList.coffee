angular.module('ahaLuminateApp')
    .factory 'profanityService', [
      '$http', 
      ($http) ->
        profanityFactory = {}
        
        profanityFactory.loadProfanityList = () ->
          if $rootScope.tablePrefix is 'heartdev'
            url = 'https://secure3.convio.net/heartdev/profanity-list/profanity-filter.json'
          else
            url = 'https://www2.heart.org/profanity-list/profanity-filter.json'
          $http.jsonp($sce.trustAsResourceUrl(url), jsonpCallbackParam: 'callback').then (results) ->
            response
        
        profanityFactory
}]);
