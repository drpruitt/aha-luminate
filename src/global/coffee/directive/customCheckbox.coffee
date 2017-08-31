angular.module 'ahaLuminateApp'
  .directive 'customCheckbox', ->
    restrict: 'A'
    scope: {}
    link: (scope, element) ->
      $checkboxContainer = angular.element element
      $checkboxes = $checkboxContainer.find 'input[type="checkbox"]'
      angular.forEach $checkboxes, (checkbox) ->
        $checkbox = angular.element checkbox
        $checkbox.on 'focus', ->
          $checkboxContainer.addClass 'focused'
        $checkbox.on 'blur', ->
          $checkboxContainer.removeClass 'focused'