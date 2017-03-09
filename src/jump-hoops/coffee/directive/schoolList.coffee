angular.module 'ahaLuminateApp'
  .directive 'schoolList', ->
    template: '<table class="table table-responsive table-striped ym-list ym-list--school-list"> <thead class="ym-list__header"> <th class="ym-list__column ym-list__column--school"> School </th> <th class="ym-list__column ym-list__column--city"> City </th> <th class="ym-list__column ym-list__column--state"> State </th> <th class="ym-list__column ym-list__column--team-leader"> Team Leader </th> </thead> <tbody> <tr class="ym-list__row" ng-repeat="school in schools | filter:{SCHOOL_NAME:nameFilter}| filter:{SCHOOL_STATE:stateFilter}"> <td class="ym-list__column ym-list__column--school">{{school.SCHOOL_NAME}}<br/> <a class="btn btn-primary btn-md" ng-href="#">Sign Up</a> </td><td class="ym-list__column ym-list__column--city">{{school.SCHOOL_CITY}}</td><td class="ym-list__column ym-list__column--state">{{school.SCHOOL_STATE}}</td><td class="ym-list__column ym-list__column--team-leader">{{school.COORDINATOR_FIRST_NAME}} {{school.COORDINATOR_LAST_NAME}}</td></tr></tbody></table>'
    restrict: 'E'
    replace: true
    require: 'ngModel'
    scope:
      schools: '='
      nameFilter: '='
      stateFilter: '='
