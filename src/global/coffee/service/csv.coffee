angular.module 'ahaLuminateApp'
  .factory 'CsvService', [
    '$rootScope'
    ($rootScope) ->
      toJson: (csvStr) ->
        lines = this.toArray csvStr
        result = []
        headers = lines[0]
        lines.splice 0, 1
        angular.forEach lines, (line) ->
          obj = {}
          if line.length is headers.length
            angular.forEach headers, (header, headerIndex) ->
              obj[header] = line[headerIndex]
            result.push obj
        result
      
      toArray: (csvStr) ->
        strDelimiter = ','
        objPattern = new RegExp('(\\' + strDelimiter + '|\\r?\\n|\\r|^)' + '(?:"([^"]*(?:""[^"]*)*)"|' + '([^"\\' + strDelimiter + '\\r\\n]*))', 'gi')
        arrData = [ [] ]
        arrMatches = null
        while arrMatches = objPattern.exec csvStr
          strMatchedDelimiter = arrMatches[1]
          strMatchedValue = undefined
          if strMatchedDelimiter.length and strMatchedDelimiter isnt strDelimiter
            arrData.push []
          if arrMatches[2]
            strMatchedValue = arrMatches[2].replace(new RegExp('""', 'g'), '"')
          else
            strMatchedValue = arrMatches[3]
          arrData[arrData.length - 1].push strMatchedValue
        arrData
  ]