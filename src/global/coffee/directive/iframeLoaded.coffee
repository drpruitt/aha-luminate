angular.module 'ahaLuminateApp'
  .directive 'iframeLoaded', ->
    restrict: 'A'
    scope:
      iframeLoaded: '='
    link: (scope, element, attrs) ->
      element.on 'load', ->
        scope.iframeLoaded(element)