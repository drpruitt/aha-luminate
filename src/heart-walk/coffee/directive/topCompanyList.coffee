angular.module 'ahaLuminateApp'
  .directive 'topCompanyList', [
    'APP_INFO'
    (APP_INFO) ->
      templateUrl: APP_INFO.rootPath + 'dist/heart-walk/html/directive/topCompanyList.html'
      restrict: 'E'
      replace: true
      scope:
        companies: '='
        maxSize: '='
    ]