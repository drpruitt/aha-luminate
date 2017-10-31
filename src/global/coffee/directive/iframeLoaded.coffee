angular.module 'ahaLuminateApp'
  .directive 'iframeLoaded', ->
    restrict: 'A'
    scope:
      iframeLoaded: '='
    link: (scope, element) ->
      element.on 'load', ->
        scope.iframeLoaded element