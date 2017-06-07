angular.module 'ahaLuminateApp'
  .factory 'TeamraiserCompanyService', [
    'LuminateRESTService'
    '$http'
    '$filter'
    (LuminateRESTService, $http, $filter) ->
      topCompanies = null
      
      setTopCompanies = (companies) ->
        topCompanies = companies
      
      getCompanies = (requestData, callback) ->
        dataString = 'method=getCompaniesByInfo'
        dataString += '&' + requestData if requestData and requestData isnt ''
        LuminateRESTService.luminateExtendTeamraiserRequest dataString, false, true, callback
      
      getCompanyList = (requestData, callback) ->
        dataString = 'method=getCompanyList'
        dataString += '&' + requestData if requestData and requestData isnt ''
        LuminateRESTService.luminateExtendTeamraiserRequest dataString, false, true, callback
      
      getTopCompanies = (callback) ->
        if topCompanies
          callback.success topCompanies
          return
        getCompanyList 'include_all_companies=true', 
          error: ->
            setTopCompanies []
            callback.success topCompanies
          success: (response) ->
            companyItems = response.getCompanyListResponse?.companyItem or []
            companyItems = [companyItems] if not angular.isArray companyItems
            rootAncestorCompanies = []
            childCompanyIdMap = {}
            angular.forEach companyItems, (companyItem) ->
              if companyItem.parentOrgEventId is '0'
                rootAncestorCompany =
                  companyId: companyItem.companyId
                  companyName: companyItem.companyName
                  amountRaised: if companyItem.amountRaised then Number(companyItem.amountRaised) else 0
                rootAncestorCompanies.push rootAncestorCompany
            angular.forEach companyItems, (companyItem) ->
              parentOrgEventId = companyItem.parentOrgEventId
              if parentOrgEventId isnt '0'
                childCompanyIdMap['company-' + companyItem.companyId] = parentOrgEventId
            angular.forEach childCompanyIdMap, (value, key) ->
              if childCompanyIdMap['company-' + value]
                childCompanyIdMap[key] = childCompanyIdMap['company-' + value]
            angular.forEach childCompanyIdMap, (value, key) ->
              if childCompanyIdMap['company-' + value]
                childCompanyIdMap[key] = childCompanyIdMap['company-' + value]
            angular.forEach companyItems, (companyItem) ->
              if companyItem.parentOrgEventId isnt '0'
                rootParentCompanyId = childCompanyIdMap['company-' + companyItem.companyId]
                childCompanyAmountRaised = if companyItem.amountRaised then Number(companyItem.amountRaised) else 0
                angular.forEach rootAncestorCompanies, (rootAncestorCompany, rootAncestorCompanyIndex) ->
                  if rootAncestorCompany.companyId is rootParentCompanyId
                    rootAncestorCompanies[rootAncestorCompanyIndex].amountRaised = rootAncestorCompanies[rootAncestorCompanyIndex].amountRaised + childCompanyAmountRaised
            angular.forEach rootAncestorCompanies, (rootAncestorCompany, rootAncestorCompanyIndex) ->
              rootAncestorCompanies[rootAncestorCompanyIndex].amountRaisedFormatted = $filter('currency') rootAncestorCompany.amountRaised / 100, '$', 0
            getCompanies 'list_sort_column=total&list_ascending=false&list_page_size=500', 
              error: ->
                setTopCompanies []
                callback.success topCompanies
              success: (response) ->
                companies = response.getCompaniesResponse?.company or []
                companies = [companies] if not angular.isArray companies
                angular.forEach companies, (company) ->
                  companyId = company.companyId
                  participantCount = if company.participantCount then Number(company.participantCount) else 0
                  teamCount = if company.teamCount then Number(company.teamCount) else 0
                  angular.forEach rootAncestorCompanies, (rootAncestorCompany, rootAncestorCompanyIndex) ->
                    if rootAncestorCompany.companyId is companyId
                      rootAncestorCompanies[rootAncestorCompanyIndex].participantCount = participantCount
                      rootAncestorCompanies[rootAncestorCompanyIndex].teamCount = teamCount
                angular.forEach companies, (company) ->
                  companyId = company.companyId
                  rootParentCompanyId = childCompanyIdMap['company-' + companyId]
                  if rootParentCompanyId
                    participantCount = if company.participantCount then Number(company.participantCount) else 0
                    teamCount = if company.teamCount then Number(company.teamCount) else 0
                    angular.forEach rootAncestorCompanies, (rootAncestorCompany, rootAncestorCompanyIndex) ->
                      if rootAncestorCompany.companyId is rootParentCompanyId
                        rootAncestorCompanies[rootAncestorCompanyIndex].participantCount = rootAncestorCompanies[rootAncestorCompanyIndex].participantCount + participantCount
                        rootAncestorCompanies[rootAncestorCompanyIndex].teamCount = rootAncestorCompanies[rootAncestorCompanyIndex].teamCount + teamCount
                setTopCompanies rootAncestorCompanies
                callback.success topCompanies
      
      {
        getCompanies: getCompanies
        getCompanyList: getCompanyList
        getTopCompanies: getTopCompanies,
        getCoordinatorQuestion: (coordinatorId, eventId) ->
          $http
            method: 'GET'
            url: 'PageServer?pagename=ym_coordinator_data&pgwrap=n&consId=' + coordinatorId + '&frId=' + eventId
          .then (response) ->
            response
      }
  ]