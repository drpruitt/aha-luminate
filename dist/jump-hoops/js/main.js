(function() {
  angular.module('ahaLuminateApp', ['ngSanitize', 'ui.bootstrap', 'ahaLuminateControllers']);

  angular.module('ahaLuminateControllers', []);

  angular.module('ahaLuminateApp').constant('APP_INFO', {
    version: '1.0.0'
  });

  angular.module('ahaLuminateApp').run([
    '$rootScope', 'APP_INFO', function($rootScope, APP_INFO) {
      var $dataRoot;
      $dataRoot = angular.element('[data-aha-luminate-root]');
      if ($dataRoot.data('api-key') !== '') {
        $rootScope.apiKey = $dataRoot.data('api-key');
      }
      if (!$rootScope.apiKey) {
        new Error('AHA Luminate Framework: No Luminate Online API Key is defined.');
      }
      if ($dataRoot.data('cons-id') !== '') {
        $rootScope.consId = $dataRoot.data('cons-id');
      }
      if ($dataRoot.data('auth-token') !== '') {
        $rootScope.authToken = $dataRoot.data('auth-token');
      }
      if ($dataRoot.data('fr-id') !== '') {
        return $rootScope.frId = $dataRoot.data('fr-id');
      }
    }
  ]);

  angular.element(document).ready(function() {
    var appModules;
    appModules = ['ahaLuminateApp'];
    return angular.bootstrap(document, appModules);
  });

  angular.module('ahaLuminateControllers').controller('MainCtrl', [
    '$scope', function($scope) {
      $scope.toggleLoginMenu = function() {
        if ($scope.loginMenuOpen) {
          return delete $scope.loginMenuOpen;
        } else {
          return $scope.loginMenuOpen = true;
        }
      };
      angular.element('body').on('click', function(event) {
        if ($scope.loginMenuOpen && angular.element(event.target).closest('.ym-header-login').length === 0) {
          return $scope.toggleLoginMenu();
        }
      });
      $scope.submitHeaderLogin = function() {};
      $scope.toggleSiteMenu = function() {
        if ($scope.siteMenuOpen) {
          return delete $scope.siteMenuOpen;
        } else {
          return $scope.siteMenuOpen = true;
        }
      };
      return angular.element('body').on('click', function(event) {
        if ($scope.siteMenuOpen && angular.element(event.target).closest('.ym-site-menu').length === 0) {
          return $scope.toggleSiteMenu();
        }
      });
    }
  ]);

}).call(this);
