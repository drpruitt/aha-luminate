angular.module 'ahaLuminateApp'
  .factory 'CsvService', [
    '$rootScope'
    ($rootScope) ->
      toJson: (csvStr) ->
        console.log 'enter csv'
        console.log csvStr
        lines = this.toArray csvStr
        result = []
        headers = lines[0]
        lines.splice 0, 1
        i = 0
        while i < lines.length
          currentline = lines[i]
          obj = {}
          if currentline.length is headers.length
            j = 0
            while j < headers.length
              obj[headers[j]] = currentline[j]
              j++
            result.push obj
          i++
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