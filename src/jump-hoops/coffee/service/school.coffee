angular.module 'ahaLuminateApp'
  .factory 'SchoolService', [
    '$http'
    '$sce'
    ($http, $sce) ->
      getSchools: (callback) ->
        url = $sce.trustAsResourceUrl luminateExtend.global.path.nonsecure + 'PageServer?pagename=jump_hoops_school_search&pgwrap=n'
        $http.jsonp(url, jsonpCallbackParam: 'callback').then (response) ->
          if not response.data.success
            callback.failure response
          else
            callback.success decodeURIComponent(response.data.success.schools.replace(/\+/g, ' '))
  ]