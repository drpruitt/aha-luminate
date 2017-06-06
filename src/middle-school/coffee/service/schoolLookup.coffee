angular.module 'ahaLuminateApp'
  .factory 'SchoolLookupService', [
    '$http'
    '$sce'
    ($http, $sce) ->
      getSchools: (callback) ->
        url = $sce.trustAsResourceUrl luminateExtend.global.path.nonsecure + 'PageServer?pagename=middle_school_search&pgwrap=n'
        $http.jsonp(url, jsonpCallbackParam: 'callback').then (response) ->
          if not response.data.success
            callback.failure response
          else
            callback.success decodeURIComponent(response.data.success.schools.replace(/\+/g, ' '))
  ]