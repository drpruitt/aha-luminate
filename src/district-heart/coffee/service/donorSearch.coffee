angular.module 'ahaLuminateApp'
  .factory 'DonorSearchService', [
    '$rootScope'
    '$http'
    '$sce'
    ($rootScope, $http, $sce) ->
      getParticipants: (firstName, lastName) ->
        # requestUrl = '/system/proxy.jsp?__proxyURL=' + encodeURIComponent(luminateExtend.global.path.secure + 'CRTeamraiserAPI')
        requestUrl = '/system/proxy.jsp?__proxyURL=' + encodeURIComponent('https://secure3.convio.net/heartdev/site/CRTeamraiserAPI')
        $http
          method: 'POST'
          url: $sce.trustAsResourceUrl requestUrl
          data: 'v=1.0&api_key=' + $rootScope.apiKey + '&response_format=json&suppress_response_codes=true&method=getParticipants&event_type=' + encodeURIComponent('District Heart Challenge') + '&team_name=' + encodeURIComponent('%') + '&first_name=' + encodeURIComponent(firstName) + '&last_name=' + encodeURIComponent(lastName) + '&list_sort_column=total&list_ascending=false&list_page_size=500'
          headers:
            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
        .then (response) ->
          response

      getTeams: (team) ->
        # requestUrl = '/system/proxy.jsp?__proxyURL=' + encodeURIComponent(luminateExtend.global.path.secure + 'CRTeamraiserAPI')
        requestUrl = '/system/proxy.jsp?__proxyURL=' + encodeURIComponent('https://secure3.convio.net/heartdev/site/CRTeamraiserAPI')
        $http
          method: 'POST'
          url: $sce.trustAsResourceUrl requestUrl
          data: 'v=1.0&api_key=' + $rootScope.apiKey + '&response_format=json&suppress_response_codes=true&method=getTeamsByInfo&event_type=' + encodeURIComponent('District Heart Challenge') + '&team_name=' + encodeURIComponent(team) + '&list_sort_column=total&list_ascending=true&list_page_size=500'
          headers:
            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
        .then (response) ->
          response
    
    
  ]