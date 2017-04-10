angular.module 'ahaLuminateApp'
  .factory 'TeamraiserParticipantService', [
    'LuminateRESTService'
    '$http'
    '$rootScope'
    (LuminateRESTService, $http, $rootScope) ->
      getParticipants: (requestData, callback) ->
        dataString = 'method=getParticipants'
        dataString += '&' + requestData if requestData and requestData isnt ''
        LuminateRESTService.luminateExtendTeamraiserRequest dataString, false, true, callback

      getRegisteredTeamraisers: (requestData, callback) ->
        dataString = 'method=getRegisteredTeamraisers'
        dataString += '&' + requestData if requestData and requestData isnt ''
        LuminateRESTService.luminateExtendTeamraiserRequest dataString, false, true, callback

      getRegisteredTeamraisersCMS: (requestData, callback) ->
        console.log 'enter service'
        ###
        luminateExtend.global.update
          path:
            secure: 'https://www2.heart.org/site'
        ###

        luminateExtend.api 
          api: 'teamraiser'
          data: 'method=getRegisteredTeamraisers&'+requestData            
          callback: callback || angular.noop

  ]