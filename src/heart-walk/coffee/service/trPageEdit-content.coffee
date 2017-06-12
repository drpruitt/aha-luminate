angular.module 'trPageEditApp'
  .factory 'ContentService', [
    'NgPageEditLuminateRESTService'
    (NgPageEditLuminateRESTService) ->
      getMessageBundle: ->
        NgPageEditLuminateRESTService.contentRequest 'method=getMessageBundle', true, true
          .then (response) ->
            response
  ]