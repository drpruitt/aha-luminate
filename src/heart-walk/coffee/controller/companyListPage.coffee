angular.module 'ahaLuminateControllers'
  .controller 'CompanyListPageCtrl', [
    '$scope'
    '$filter'
    'TeamraiserCompanyDataService'
    ($scope, $filter, TeamraiserCompanyDataService) ->
      $scope.topCompanies = {}
      TeamraiserCompanyDataService.getCompanyData()
        .then (response) ->
          companies = response.data.getCompanyDataResponse?.company
          if not companies
            $scope.topCompanies.companies = []
          else
            topCompanies = []
            csvToArray = (strData) ->
              strDelimiter = ','
              objPattern = new RegExp ("(\\" + strDelimiter + "|\\r?\\n|\\r|^)" + "(?:\"([^\"]*(?:\"\"[^\"]*)*)\"|" + "([^\"\\" + strDelimiter + "\\r\\n]*))"), "gi"
              arrData = [[]]
              arrMatches = null
              while arrMatches = objPattern.exec(strData)
                strMatchedDelimiter = arrMatches[1]
                strMatchedValue = undefined
                if strMatchedDelimiter.length and strMatchedDelimiter isnt strDelimiter
                  arrData.push []
                if arrMatches[2]
                  strMatchedValue = arrMatches[2].replace new RegExp("\"\"", "g"), "\""
                else
                  strMatchedValue = arrMatches[3]
                arrData[arrData.length - 1].push strMatchedValue
              arrData
            # TODO: don't include companies with $0 raised
            angular.forEach companies, (company) ->
              if company isnt ''
                companyData = csvToArray(company)[0]
                topCompanies.push
                  "eventId": $scope.frId
                  "companyId": companyData[0]
                  "participantCount": companyData[3]
                  "companyName": companyData[1]
                  "teamCount": companyData[4]
                  "amountRaised": Number(companyData[2]) * 100
                  "amountRaisedFormatted": $filter('currency')(Number(companyData[2]), '$').replace '.00', ''
            $scope.topCompanies.companies = $filter('orderBy') topCompanies, 'companyName', true
  ]