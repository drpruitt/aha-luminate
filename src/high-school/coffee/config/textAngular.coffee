if luminateExtend.global.hasTextEditor
  angular.module 'ahaLuminateApp'
    .config [
      '$provide'
      ($provide) ->
        $provide.decorator 'taOptions', [
          '$delegate'
          ($delegate) ->
            taOptions.keyMappings = [
              {
                commandKeyCode: 'TabKey'
                testForKey: (event) ->
                  false
              }
              {
                commandKeyCode: 'ShiftTabKey'
                testForKey: (event) ->
                  false
              }
            ]
            
            $delegate
        ]
    ]