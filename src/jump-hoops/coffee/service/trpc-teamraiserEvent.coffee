angular.module 'trPcApp'
  .factory 'NgPcTeamraiserEventService', [
    '$rootScope'
    'NgPcLuminateRESTService'
    ($rootScope, NgPcLuminateRESTService) ->
      getConfig: ->
        NgPcLuminateRESTService.teamraiserRequest 'method=getTeamraiserConfig', false, true
          .then (response) ->
            teamraiserConfig = response.data.getTeamraiserConfigResponse.teamraiserConfig
            if not teamraiserConfig
              $rootScope.teamraiserConfig = -1
            else
              $rootScope.teamraiserConfig = teamraiserConfig
            response
      
      getTeamraisers: (requestData) ->
        dataString = 'method=getTeamraisersByInfo'
        dataString += '&' + requestData if requestData and requestData isnt ''
        NgPcLuminateRESTService.teamraiserRequest dataString, false, false
          .then (response) ->
            response
      
      getTeamraiser: ->
        this.getTeamraisers 'list_filter_column=frc.fr_id&list_filter_text=' + $rootScope.frId + '&name=' + encodeURIComponent('%')
          .then (response) ->
            teamraisers = response.data.getTeamraisersResponse?.teamraiser
            if not teamraisers
              $rootScope.eventInfo = -1
            else
              teamraisers = [teamraiser] if not angular.isArray teamraisers
              teamraiser = teamraisers[0]
              donate_event_url = teamraiser.donate_event_url
              if donate_event_url and donate_event_url.indexOf('df_id=') isnt -1
                teamraiser.donationFormId = donate_event_url.split('df_id=')[1].split('&')[0]
              $rootScope.eventInfo = teamraiser
            response
      
      getEventDataParameter: (requestData) ->
        dataString = 'method=getEventDataParameter'
        dataString += '&' + requestData if requestData and requestData isnt ''
        NgPcLuminateRESTService.teamraiserRequest dataString, false, true
          .then (response) ->
            response
  ]