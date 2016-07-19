(function() {
  angular.module('ahaLuminateApp', ['ngSanitize', 'ahaLuminateControllers']);

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
              requestData += '&v=1.0&api_key=' + $rootScope.apiKey + '&response_format=json&suppress_response_codes=true';
              if (includeAuth && !$rootScope.authToken) {

              } else {
                if (includeAuth) {
                  requestData += '&auth=' + $rootScope.authToken;
                }
                if (includeFrId) {
                  requestData += '&fr_id=' + $rootScope.frId + '&s_trID=' + $rootScope.frId;
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
        luminateExtendRequest: function(apiServlet, requestData, includeAuth, includeFrId, callback) {
          if (!luminateExtend) {

          } else {
            if (!requestData) {

            } else {
              if (includeFrId) {
                requestData += '&fr_id=' + $rootScope.frId + '&s_trID=' + $rootScope.frId;
              }
              return luminateExtend.api({
                api: apiServlet,
                data: requestData,
                requiresAuth: includeAuth,
                callback: callback || angular.noop
              });
            }
          }
        },
        teamraiserRequest: function(requestData, includeAuth, includeFrId) {
          return this.request('CRTeamraiserAPI', requestData, includeAuth, includeFrId);
        },
        luminateExtendTeamraiserRequest: function(requestData, includeAuth, includeFrId, callback) {
          return this.luminateExtendRequest('teamraiser', requestData, includeAuth, includeFrId, callback);
        }
      };
    }
  ]);

  angular.module('ahaLuminateApp').factory('TeamraiserCompanyService', [
    'LuminateRESTService', function(LuminateRESTService) {
      return {
        getCompanies: function(requestData, callback) {
          var dataString;
          dataString = 'method=getCompaniesByInfo';
          if (requestData && requestData !== '') {
            dataString += '&' + requestData;
          }
          return LuminateRESTService.luminateExtendTeamraiserRequest(dataString, false, true, callback);
        }
      };
    }
  ]);

  angular.module('ahaLuminateApp').factory('TeamraiserParticipantService', [
    'LuminateRESTService', function(LuminateRESTService) {
      return {
        getParticipants: function(requestData, callback) {
          var dataString;
          dataString = 'method=getParticipants';
          if (requestData && requestData !== '') {
            dataString += '&' + requestData;
          }
          return LuminateRESTService.luminateExtendTeamraiserRequest(dataString, false, true, callback);
        }
      };
    }
  ]);

  angular.module('ahaLuminateApp').factory('TeamraiserTeamService', [
    'LuminateRESTService', function(LuminateRESTService) {
      return {
        getTeams: function(requestData, callback) {
          var dataString;
          dataString = 'method=getTeamsByInfo';
          if (requestData && requestData !== '') {
            dataString += '&' + requestData;
          }
          return LuminateRESTService.luminateExtendTeamraiserRequest(dataString, false, true, callback);
        }
      };
    }
  ]);

  angular.module('ahaLuminateApp').directive('eqColumnHeight', [
    '$window', '$timeout', function($window, $timeout) {
      return {
        restrict: 'A',
        link: function(scope, element) {
          var resizeColumns;
          resizeColumns = function() {
            var columnHeight;
            angular.element(element).css('height', '');
            angular.element(element).siblings('[class*="col-"]').css('height', '');
            columnHeight = Number(angular.element(element).css('height').replace('px', ''));
            angular.element(element).siblings('[class*="col-"]').each(function() {
              var siblingHeight;
              siblingHeight = Number(angular.element(this).css('height').replace('px', ''));
              if (siblingHeight > columnHeight) {
                return columnHeight = siblingHeight;
              }
            });
            angular.element(element).css('height', columnHeight + 'px');
            return angular.element(element).siblings('[class*="col-"]').css('height', columnHeight + 'px');
          };
          $timeout(resizeColumns, 500);
          return angular.element($window).bind('resize', function() {
            resizeColumns();
            return scope.$digest();
          });
        }
      };
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

  angular.module('ahaLuminateControllers').controller('GreetingPageCtrl', [
    '$scope', 'TeamraiserParticipantService', 'TeamraiserTeamService', 'TeamraiserCompanyService', function($scope, TeamraiserParticipantService, TeamraiserTeamService, TeamraiserCompanyService) {
      var setTopCompanies, setTopParticipants, setTopTeams;
      $scope.topParticipants = {};
      setTopParticipants = function(participants) {
        $scope.topParticipants.participants = participants;
        if (!$scope.$$phase) {
          return $scope.$apply();
        }
      };
      TeamraiserParticipantService.getParticipants('first_name=' + encodeURIComponent('%%%') + '&list_sort_column=total&list_ascending=false', {
        error: function() {
          return setTopParticipants([]);
        },
        success: function(response) {
          var topParticipants;
          topParticipants = response.getParticipantsResponse.participant || [];
          if (!angular.isArray(topParticipants)) {
            topParticipants = [topParticipants];
          }
          return setTopParticipants(topParticipants);
        }
      });
      $scope.topTeams = {};
      setTopTeams = function(teams) {
        $scope.topTeams.teams = teams;
        if (!$scope.$$phase) {
          return $scope.$apply();
        }
      };
      TeamraiserTeamService.getTeams('list_sort_column=total&list_ascending=false', {
        error: function() {
          return setTopTeams([]);
        },
        success: function(response) {
          var topTeams;
          topTeams = response.getTeamSearchByInfoResponse.team || [];
          if (!angular.isArray(topTeams)) {
            topTeams = [topTeams];
          }
          return setTopTeams(topTeams);
        }
      });
      $scope.topCompanies = {};
      setTopCompanies = function(companies) {
        $scope.topCompanies.companies = companies;
        if (!$scope.$$phase) {
          return $scope.$apply();
        }
      };
      return TeamraiserCompanyService.getCompanies('list_sort_column=total&list_ascending=false', {
        error: function() {
          return setTopCompanies([]);
        },
        success: function(response) {
          var topCompanies;
          topCompanies = response.getCompaniesResponse.company || [];
          if (!angular.isArray(topCompanies)) {
            topCompanies = [topCompanies];
          }
          return setTopCompanies(topCompanies);
        }
      });
    }
  ]);

  angular.module('ahaLuminateControllers').controller('MainCtrl', [
    '$scope', function($scope) {
      return angular.element('body').on('click', '.addthis_button_facebook', function(e) {
        return e.preventDefault();
      });
    }
  ]);

}).call(this);
