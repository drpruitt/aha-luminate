angular.module 'ahaLuminateControllers'
  .controller 'CompanyListPageCtrl', [
    '$scope'
    '$filter'
    'TeamraiserCompanyDataService'
    ($scope, $filter, TeamraiserCompanyDataService) ->
      $scope.topCompanies = 
        'ng_sort_column': null
        'ng_sort_reverse': null
      
      $scope.sortCompanyList = (column) ->
        if $scope.topCompanies.ng_sort_column is column and $scope.topCompanies.ng_sort_reverse is false
          $scope.topCompanies.ng_sort_reverse = true
        else
          $scope.topCompanies.ng_sort_reverse = false
        $scope.topCompanies.companies = $filter('orderBy') $scope.topCompanies.companies, column, $scope.topCompanies.ng_sort_reverse
        $scope.topCompanies.ng_sort_column = column
      
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
                  "participantCount": Number companyData[3]
                  "companyName": companyData[1]
                  "teamCount": Number companyData[4]
                  "amountRaised": Number(companyData[2]) * 100
                  "amountRaisedFormatted": $filter('currency')(Number(companyData[2]), '$', 0)
            $scope.topCompanies.companies = topCompanies
            $scope.sortCompanyList 'companyName'
  ]