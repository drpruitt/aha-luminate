angular.module 'ahaLuminateApp'
  .config [
    '$provide'
    ($provide) ->
      $provide.decorator 'taTools', [
        '$delegate'
        (taTools) ->
          console.log 'config text'
          taTools.bold.display = '<button type="button" class="btn btn-default" ng-class="displayActiveToolClass(active)" ta-button name="bold" title="Bold" ng-disabled="isDisabled()" ng-click="executeAction()" tabindex="0">' + 
            '<i class="fa fa-bold"></i>' + 
          '</button>'
          taTools.italics.display = '<button type="button" class="btn btn-default" ng-class="displayActiveToolClass(active)" ta-button name="italics" title="Italic" ng-disabled="isDisabled()" ng-click="executeAction()">' + 
            '<i class="fa fa-italic"></i>' + 
          '</button>'
          taTools.underline.display = '<button type="button" class="btn btn-default" ng-class="displayActiveToolClass(active)" ta-button name="underline" title="Underline" ng-disabled="isDisabled()" ng-click="executeAction()">' + 
            '<i class="fa fa-underline"></i>' + 
          '</button>'
          taTools.ul.display = '<button type="button" class="btn btn-default" ng-class="displayActiveToolClass(active)" ta-button name="ul" title="Unordered List" ng-disabled="isDisabled()" ng-click="executeAction()">' + 
            '<i class="fa fa-list-ul"></i>' + 
          '</button>'
          taTools.ol.display = '<button type="button" class="btn btn-default" ng-class="displayActiveToolClass(active)" ta-button name="ol" title="Ordered List" ng-disabled="isDisabled()" ng-click="executeAction()">' + 
            '<i class="fa fa-list-ol"></i>' + 
          '</button>'
          taTools.insertLink.display = '<button type="button" class="btn btn-default" ng-class="displayActiveToolClass(active)" ta-button name="insertLink" title="Insert / edit link" ng-disabled="isDisabled()" ng-click="executeAction()">' + 
            '<i class="fa fa-link"></i>' + 
          '</button>'
          taTools.insertImage.display = '<button type="button" class="btn btn-default" ng-class="displayActiveToolClass(active)" ta-button name="insertImage" title="Insert image" ng-disabled="isDisabled()" ng-click="executeAction()">' + 
            '<i class="fa fa-picture-o"></i>' + 
          '</button>'
          taTools.undo.display = '<button type="button" class="btn btn-default" ng-class="displayActiveToolClass(active)" ta-button name="undo" title="Undo" ng-disabled="isDisabled()" ng-click="executeAction()">' + 
            '<i class="fa fa-undo"></i>' + 
          '</button>'
          taTools.redo.display = '<button type="button" class="btn btn-default" ng-class="displayActiveToolClass(active)" ta-button name="redo" title="Redo" ng-disabled="isDisabled()" ng-click="executeAction()">' + 
            '<i class="fa fa-repeat"></i>>' + 
          '</button>'
          
          taTools
      ]
  ]