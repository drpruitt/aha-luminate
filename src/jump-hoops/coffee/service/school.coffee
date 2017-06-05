angular.module 'ahaLuminateApp'
  .factory 'SchoolService', [
    '$http'
    '$sce'
    ($http, $sce) ->
      getSchools: (callback) ->
        url = $sce.trustAsResourceUrl(luminateExtend.global.path.nonsecure + 'PageServer?pagename=jump_hoops_school_search_test&pgwrap=n')
        $http.jsonp(url, jsonpCallbackParam: 'callback').then (response) ->
          #console.log response
          if response.data.success
            console.log 'success'
            #callback.success decodeURIComponent(response.data.success.schools.replace(/[+"&]/g, ' '))
            callback.success response.data.success.schools
          else
            console.log 'fail'
            callback.failure response
  ]