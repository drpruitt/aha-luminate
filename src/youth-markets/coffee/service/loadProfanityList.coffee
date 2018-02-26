angular.module('ahaLuminateApp')
    .factory('dataService', ['$http', function ($http) {
      if $rootScope.tablePrefix is 'heartdev'
        url = 'https://secure3.convio.net/heartdev/profanity-list/profanity-filter.json'
      else
        url = 'https://www2.heart.org/profanity-list/profanity-filter.json'
      $http.jsonp($sce.trustAsResourceUrl(url), jsonpCallbackParam: 'callback')
        .then (response) ->
          return response
        , (response) ->
          return response
}]);
