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

  angular.module('ahaLuminateApp').factory('TeamraiserCompanyService', [
    'LuminateRESTService', function(LuminateRESTService) {
      return {
        getCompanies: function(requestData) {
          var dataString;
          dataString = 'method=getCompaniesByInfo';
          if (requestData && requestData !== '') {
            dataString += '&' + requestData;
          }
          return LuminateRESTService.teamraiserRequest(dataString, false, true).then(function(response) {
            return response;
          });
        }
      };
    }
  ]);

  angular.module('ahaLuminateApp').factory('TeamraiserParticipantService', [
    'LuminateRESTService', function(LuminateRESTService) {
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
        }
      };
    }
  ]);

  angular.module('ahaLuminateApp').factory('TeamraiserTeamService', [
    'LuminateRESTService', function(LuminateRESTService) {
      return {
        getTeams: function(requestData) {
          var dataString;
          dataString = 'method=getTeamsByInfo';
          if (requestData && requestData !== '') {
            dataString += '&' + requestData;
          }
          return LuminateRESTService.teamraiserRequest(dataString, false, true).then(function(response) {
            return response;
          });
        }
      };
    }
  ]);

  angular.module('ahaLuminateControllers').controller('GreetingPageCtrl', [
    '$scope', 'TeamraiserParticipantService', 'TeamraiserTeamService', 'TeamraiserCompanyService', function($scope, TeamraiserParticipantService, TeamraiserTeamService, TeamraiserCompanyService) {
      TeamraiserParticipantService.getParticipants('fr_id=&first_name=' + encodeURIComponent('%%%') + '&list_sort_column=total&list_ascending=false').then(function(response) {
        var topParticipants;
        topParticipants = response.data.getParticipantsResponse.participant;
        if (!angular.isArray(topParticipants)) {
          topParticipants = [topParticipants];
        }
        return $scope.topParticipants = topParticipants;
      });
      TeamraiserTeamService.getTeams('fr_id=&list_sort_column=total&list_ascending=false').then(function(response) {
        var topTeams;
        topTeams = response.data.getTeamSearchByInfoResponse.team;
        if (!angular.isArray(topTeams)) {
          topTeams = [topTeams];
        }
        return $scope.topTeams = topTeams;
      });
      return TeamraiserCompanyService.getCompanies('fr_id=&list_sort_column=total&list_ascending=false').then(function(response) {
        var topCompanies;
        topCompanies = response.data.getCompaniesResponse.company;
        if (!angular.isArray(topCompanies)) {
          topCompanies = [topCompanies];
        }
        return $scope.topCompanies = topCompanies;
      });
    }
  ]);

  angular.module('ahaLuminateApp').directive('topCompanyList', function() {
    return {
      templateUrl: '../aha-luminate/dist/heart-walk/html/directive/topCompanyList.html',
      restrict: 'E',
      replace: true,
      scope: {
        companies: '=',
        maxSize: '='
      }
    };
  });

  angular.module('ahaLuminateApp').directive('topParticipantList', function() {
    return {
      templateUrl: '../aha-luminate/dist/heart-walk/html/directive/topParticipantList.html',
      restrict: 'E',
      replace: true,
      scope: {
        participants: '=',
        maxSize: '='
      }
    };
  });

  angular.module('ahaLuminateApp').directive('topTeamList', function() {
    return {
      templateUrl: '../aha-luminate/dist/heart-walk/html/directive/topTeamList.html',
      restrict: 'E',
      replace: true,
      scope: {
        teams: '=',
        maxSize: '='
      }
    };
  });

}).call(this);
