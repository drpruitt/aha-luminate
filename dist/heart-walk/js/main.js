(function() {
  angular.module('ahaLuminateApp', ['ngSanitize', 'ui.bootstrap', 'ahaLuminateControllers']);

  angular.module('ahaLuminateControllers', []);

  angular.module('ahaLuminateApp').constant('APP_INFO', {
    version: '1.0.0'
  });

  angular.module('ahaLuminateApp').run([
    '$rootScope', 'APP_INFO', function($rootScope, APP_INFO) {
      var $embedRoot, appVersion;
      $embedRoot = angular.element('[data-embed-root]');
      if ($embedRoot.data('app-version') !== '') {
        appVersion = $embedRoot.data('app-version');
      }
      if ($embedRoot.data('api-key') !== '') {
        $rootScope.apiKey = $embedRoot.data('api-key');
      }
      if (!$rootScope.apiKey) {
        new Error('AHA Luminate Framework: No Luminate Online API Key is defined.');
      }
      if ($embedRoot.data('cons-id') !== '') {
        $rootScope.consId = $embedRoot.data('cons-id');
      }
      if ($embedRoot.data('auth-token') !== '') {
        $rootScope.authToken = $embedRoot.data('auth-token');
      }
      if ($embedRoot.data('fr-id') !== '') {
        return $rootScope.frId = $embedRoot.data('fr-id');
      }
    }
  ]);

  angular.element(document).ready(function() {
    return angular.bootstrap(document, ['ahaLuminateApp']);
  });

  angular.module('ahaLuminateApp').factory('LuminateRESTService', [
    '$rootScope', '$http', 'APP_INFO', function($rootScope, $http, APP_INFO) {
      return {
        request: function(apiServlet, requestData, includeAuth, includeFrId) {
          if (!requestData) {

          } else {
            if (!$rootScope.apiKey) {

            } else {
              requestData += '&v=1.0&api_key=' + $rootScope.apiKey + '&response_format=json&suppress_response_codes=true&ng_tr_pc_v=' + APP_INFO.version;
              if (includeAuth && !$rootScope.authToken) {

              } else {
                if (includeAuth) {
                  requestData += '&auth=' + $rootScope.authToken;
                }
                if (includeFrId) {
                  requestData += '&fr_id=' + $rootScope.frId + '&s_trID=' + $rootScope.frId;
                }
                if ($rootScope.locale) {
                  requestData += '&s_locale=' + $rootScope.locale;
                }
                return $http({
                  method: 'POST',
                  url: apiServlet,
                  data: requestData,
                  headers: {
                    'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
                  }
                }).then(function(response) {
                  return response;
                });
              }
            }
          }
        },
        teamraiserRequest: function(requestData, includeAuth, includeFrId) {
          return this.request('CRTeamraiserAPI', requestData, includeAuth, includeFrId);
        }
      };
    }
  ]);

  angular.module('ahaLuminateApp').factory('TeamraiserParticipantService', [
    '$rootScope', 'LuminateRESTService', function($rootScope, LuminateRESTService) {
      return {
        getParticipants: function(requestData) {
          var dataString;
          dataString = 'method=getParticipants';
          if (requestData && requestData !== '') {
            dataString += '&' + requestData;
          }
          return LuminateRESTService.teamraiserRequest(dataString, false, true).then(function(response) {
            return response;
          });
        },
        getParticipant: function() {
          return this.getParticipants('first_name=' + encodeURIComponent('%%%') + '&list_filter_column=reg.cons_id&list_filter_text=' + $rootScope.consId);
        }
      };
    }
  ]);

  angular.module('ahaLuminateApp').directive('topParticipantList', function() {
    return {
      templateUrl: '../aha-luminate/dist/heart-walk/html/directive/topParticipantList.html',
      restrict: 'E',
      replace: true,
      scope: {
        maxSize: '='
      }
    };
  });

}).call(this);
