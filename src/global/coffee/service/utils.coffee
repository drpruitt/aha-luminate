angular.module 'ahaLuminateApp'
  .factory 'UtilsService', ->
    {
      unique: (arr) ->
        n = {}
        r = []
        i = 0
        while i < arr.length
          if !n[arr[i]]
            n[arr[i]] = true
            r.push arr[i]
          i++
        r
    }