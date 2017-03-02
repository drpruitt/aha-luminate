angular.module 'ahaLuminateApp'
  .factory 'TeamraiserCompanyService', [
    'LuminateRESTService'
    '$http'
    (LuminateRESTService, $http) ->
      getCompanies: (requestData, callback) ->
        dataString = 'method=getCompaniesByInfo'
        dataString += '&' + requestData if requestData and requestData isnt ''
        LuminateRESTService.luminateExtendTeamraiserRequest dataString, false, true, callback
      
      getCompanyList: (requestData, callback) ->
        dataString = 'method=getCompanyList'
        dataString += '&' + requestData if requestData and requestData isnt ''
        LuminateRESTService.luminateExtendTeamraiserRequest dataString, false, true, callback

      getCoordinatorQuestion: (coordinatorId, eventId) ->
        $http
          method: 'GET'
          url: 'PageServer?pagename=ym_coordinator_data&pgwrap=n&consId='+coordinatorId+'&frId='+eventId
        .then (response) ->
          response

      getSchools: (name) ->
        $http
          method: 'GET'
          url: 'PageServer?pagename=jump_hoops_school_search&pgwrap=n&name='+name
        .then (response) ->
          response
  ]