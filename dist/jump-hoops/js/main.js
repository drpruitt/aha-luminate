(function() {
  angular.module('ahaLuminateApp', ['ngSanitize', 'ngTouch', 'ui.bootstrap', 'ahaLuminateControllers']);

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
    var appModules, error, error1;
    appModules = ['ahaLuminateApp'];
    try {
      angular.module('trPcApp');
      appModules.push('trPcApp');
    } catch (error1) {
      error = error1;
    }
    return angular.bootstrap(document, appModules);
  });

  angular.module('ahaLuminateApp').factory('AuthService', [
    'LuminateRESTService', function(LuminateRESTService) {
      return {
        login: function(requestData, callback) {
          var dataString;
          dataString = 'method=login';
          if (requestData && requestData !== '') {
            dataString += '&' + requestData;
          }
          return LuminateRESTService.luminateExtendConsRequest(dataString, false, callback);
        }
      };
    }
  ]);

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
        },
        consRequest: function(requestData, includeAuth) {
          return this.request('CRConsAPI', requestData, includeAuth, false);
        },
        luminateExtendConsRequest: function(requestData, includeAuth, callback) {
          return this.luminateExtendRequest('cons', requestData, includeAuth, false, callback);
        }
      };
    }
  ]);

  angular.module('ahaLuminateApp').factory('TeamraiserCompanyService', [
    'LuminateRESTService', '$http', function(LuminateRESTService, $http) {
      return {
        getCompanies: function(requestData, callback) {
          var dataString;
          dataString = 'method=getCompaniesByInfo';
          if (requestData && requestData !== '') {
            dataString += '&' + requestData;
          }
          return LuminateRESTService.luminateExtendTeamraiserRequest(dataString, false, true, callback);
        },
        getCompanyList: function(requestData, callback) {
          var dataString;
          dataString = 'method=getCompanyList';
          if (requestData && requestData !== '') {
            dataString += '&' + requestData;
          }
          return LuminateRESTService.luminateExtendTeamraiserRequest(dataString, false, true, callback);
        },
        getCoordinatorQuestion: function(coordinatorId) {
          return $http({
            method: 'GET',
            url: 'PageServer?pagename=ym_coordinator_data&pgwrap=n&consId=' + coordinatorId + 'frId=2520'
          }).then(function(response) {
            return response;
          });
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

  angular.module('ahaLuminateControllers').controller('CompanyPageCtrl', [
    '$scope', '$location', '$filter', '$timeout', 'TeamraiserCompanyService', 'TeamraiserTeamService', 'TeamraiserParticipantService', function($scope, $location, $filter, $timeout, TeamraiserCompanyService, TeamraiserTeamService, TeamraiserParticipantService) {
      var getCompanyParticipants, getCompanyTeams, getCompanyTotals, setCompanyFundraisingProgress, setCompanyParticipants, setCompanyTeams;
      $scope.companyId = $location.absUrl().split('company_id=')[1].split('&')[0];
      $scope.companyProgress = [];
      setCompanyFundraisingProgress = function(amountRaised, goal) {
        $scope.companyProgress.amountRaised = amountRaised;
        $scope.companyProgress.amountRaised = Number($scope.companyProgress.amountRaised);
        $scope.companyProgress.amountRaisedFormatted = $filter('currency')($scope.companyProgress.amountRaised / 100, '$').replace('.00', '');
        $scope.companyProgress.goal = goal || 0;
        $scope.companyProgress.goal = Number($scope.companyProgress.goal);
        $scope.companyProgress.goalFormatted = $filter('currency')($scope.companyProgress.goal / 100, '$').replace('.00', '');
        $scope.companyProgress.percent = 2;
        $timeout(function() {
          var percent;
          percent = $scope.companyProgress.percent;
          if ($scope.companyProgress.goal !== 0) {
            percent = Math.ceil(($scope.companyProgress.amountRaised / $scope.companyProgress.goal) * 100);
          }
          if (percent < 2) {
            percent = 2;
          }
          if (percent > 98) {
            percent = 98;
          }
          $scope.companyProgress.percent = percent;
          if (!$scope.$$phase) {
            return $scope.$apply();
          }
        }, 500);
        if (!$scope.$$phase) {
          return $scope.$apply();
        }
      };
      getCompanyTotals = function() {
        return TeamraiserCompanyService.getCompanies('company_id=' + $scope.companyId, {
          success: function(response) {
            var amountRaised, goal;
            amountRaised = response.getCompaniesResponse.company.amountRaised;
            goal = response.getCompaniesResponse.company.goal;
            return setCompanyFundraisingProgress(amountRaised, goal);
          }
        });
      };
      getCompanyTotals();
      $scope.companyTeams = [];
      setCompanyTeams = function(teams, totalNumber) {
        $scope.companyTeams.teams = teams || [];
        totalNumber = totalNumber || 0;
        $scope.companyTeams.totalNumber = Number(totalNumber);
        if (!$scope.$$phase) {
          return $scope.$apply();
        }
      };
      getCompanyTeams = function() {
        return TeamraiserTeamService.getTeams('team_company_id=' + $scope.companyId, {
          success: function(response) {
            var companyTeams, totalNumberTeams;
            setCompanyTeams();
            companyTeams = response.getTeamSearchByInfoResponse.team;
            if (companyTeams) {
              if (!angular.isArray(companyTeams)) {
                companyTeams = [companyTeams];
              }
              angular.forEach(companyTeams, function(companyTeam) {
                var joinTeamURL;
                companyTeam.amountRaised = Number(companyTeam.amountRaised);
                companyTeam.amountRaisedFormatted = $filter('currency')(companyTeam.amountRaised / 100, '$').replace('.00', '');
                joinTeamURL = companyTeam.joinTeamURL;
                if (joinTeamURL) {
                  return companyTeam.joinTeamURL = joinTeamURL.split('/site/')[1];
                }
              });
              totalNumberTeams = response.getTeamSearchByInfoResponse.totalNumberResults;
              return setCompanyTeams(companyTeams, totalNumberTeams);
            }
          }
        });
      };
      getCompanyTeams();
      $scope.companyParticipants = [];
      setCompanyParticipants = function(participants, totalNumber) {
        $scope.companyParticipants.participants = participants || [];
        totalNumber = totalNumber || 0;
        $scope.companyParticipants.totalNumber = Number(totalNumber);
        if (!$scope.$$phase) {
          return $scope.$apply();
        }
      };
      getCompanyParticipants = function() {
        return TeamraiserParticipantService.getParticipants('team_name=' + encodeURIComponent('%%%') + '&first_name=' + encodeURIComponent('%%%') + '&last_name=' + encodeURIComponent('%%%') + '&list_filter_column=team.company_id&list_filter_text=' + $scope.companyId + '&list_sort_column=total&list_ascending=false', {
          error: function() {
            setCompanyParticipants();
            numCompaniesParticipantRequestComplete++;
            if (numCompaniesParticipantRequestComplete === numCompanies) {
              return setCompanyNumParticipants(numParticipants);
            }
          },
          success: function(response) {
            var companyParticipants, participants, ref, totalNumberParticipants;
            setCompanyParticipants();
            participants = (ref = response.getParticipantsResponse) != null ? ref.participant : void 0;
            if (participants) {
              if (!angular.isArray(participants)) {
                participants = [participants];
              }
              companyParticipants = [];
              angular.forEach(participants, function(participant) {
                var donationUrl, ref1;
                if ((ref1 = participant.name) != null ? ref1.first : void 0) {
                  participant.amountRaised = Number(participant.amountRaised);
                  participant.amountRaisedFormatted = $filter('currency')(participant.amountRaised / 100, '$').replace('.00', '');
                  donationUrl = participant.donationUrl;
                  if (donationUrl) {
                    participant.donationUrl = donationUrl.split('/site/')[1];
                  }
                  return companyParticipants.push(participant);
                }
              });
              totalNumberParticipants = response.getParticipantsResponse.totalNumberResults;
              return setCompanyParticipants(companyParticipants, totalNumberParticipants);
            }
          }
        });
      };
      return getCompanyParticipants();
    }
  ]);

  angular.module('ahaLuminateControllers').controller('MainCtrl', [
    '$scope', '$httpParamSerializer', 'AuthService', function($scope, $httpParamSerializer, AuthService) {
      $scope.toggleLoginMenu = function() {
        if ($scope.loginMenuOpen) {
          return delete $scope.loginMenuOpen;
        } else {
          return $scope.loginMenuOpen = true;
        }
      };
      angular.element('body').on('click', function(event) {
        if ($scope.loginMenuOpen && angular.element(event.target).closest('.ym-header-login').length === 0) {
          $scope.toggleLoginMenu();
        }
        if (!$scope.$$phase) {
          return $scope.$apply();
        }
      });
      $scope.headerLoginInfo = {
        user_name: '',
        password: ''
      };
      $scope.submitHeaderLogin = function() {
        return AuthService.login($httpParamSerializer($scope.headerLoginInfo), {
          error: function() {
            return angular.element('.js--default-header-login-form').submit();
          },
          success: function() {
            if (!$scope.headerLoginInfo.ng_nexturl || $scope.headerLoginInfo.ng_nexturl === '') {
              return window.location = window.location.href;
            } else {
              return window.location = $scope.headerLoginInfo.ng_nexturl;
            }
          }
        });
      };
      $scope.toggleWelcomeMenu = function() {
        if ($scope.welcomeMenuOpen) {
          return delete $scope.welcomeMenuOpen;
        } else {
          return $scope.welcomeMenuOpen = true;
        }
      };
      angular.element('body').on('click', function(event) {
        if ($scope.welcomeMenuOpen && angular.element(event.target).closest('.ym-header-welcome').length === 0) {
          $scope.toggleWelcomeMenu();
        }
        if (!$scope.$$phase) {
          return $scope.$apply();
        }
      });
      $scope.toggleSiteMenu = function() {
        if ($scope.siteMenuOpen) {
          return delete $scope.siteMenuOpen;
        } else {
          return $scope.siteMenuOpen = true;
        }
      };
      return angular.element('body').on('click', function(event) {
        if ($scope.siteMenuOpen && angular.element(event.target).closest('.ym-site-menu').length === 0) {
          $scope.toggleSiteMenu();
        }
        if (!$scope.$$phase) {
          return $scope.$apply();
        }
      });
    }
  ]);

  angular.module('ahaLuminateControllers').controller('PersonalPageCtrl', [
    '$scope', '$location', '$filter', '$timeout', 'TeamraiserParticipantService', 'TeamraiserCompanyService', function($scope, $location, $filter, $timeout, TeamraiserParticipantService, TeamraiserCompanyService) {
      var $dataRoot, $defaultPersonalDonors, $defaultResponsivePersonalDonors, setParticipantProgress;
      $dataRoot = angular.element('[data-aha-luminate-root]');
      $scope.participantId = $location.absUrl().split('px=')[1].split('&')[0];
      if ($dataRoot.data('company-id') !== '') {
        $scope.companyId = $dataRoot.data('company-id');
      }
      if ($dataRoot.data('team-id') !== '') {
        $scope.teamId = $dataRoot.data('team-id');
      }
      TeamraiserCompanyService.getCompanies('company_id=' + $scope.companyId, {
        error: function() {
          return console.log('error');
        },
        success: function(response) {
          var coordinatorId, eventId, ref, ref1;
          console.log(response);
          coordinatorId = (ref = response.getCompaniesResponse) != null ? ref.company.coordinatorId : void 0;
          eventId = (ref1 = response.getCompaniesResponse) != null ? ref1.company.eventId : void 0;
          return TeamraiserCompanyService.getCoordinatorQuestion(coordinatorId).then(function(response) {
            return console.log(response);
          });
        }
      });
      setParticipantProgress = function(amountRaised, goal) {
        var rawPercent;
        $scope.personalProgress = {
          amountRaised: amountRaised || 0,
          goal: goal || 0
        };
        $scope.personalProgress.amountRaisedFormatted = $filter('currency')($scope.personalProgress.amountRaised / 100, '$').replace('.00', '');
        $scope.personalProgress.goalFormatted = $filter('currency')($scope.personalProgress.goal / 100, '$').replace('.00', '');
        if ($scope.personalProgress.goal === 0) {
          $scope.personalProgress.rawPercent = 0;
        } else {
          rawPercent = Math.ceil(($scope.personalProgress.amountRaised / $scope.personalProgress.goal) * 100);
          if (rawPercent > 100) {
            rawPercent = 100;
          }
          $scope.personalProgress.rawPercent = rawPercent;
        }
        $scope.personalProgress.percent = 0;
        if (!$scope.$$phase) {
          $scope.$apply();
        }
        return $timeout(function() {
          var percent;
          percent = $scope.personalProgress.percent;
          if ($scope.personalProgress.goal !== 0) {
            percent = Math.ceil(($scope.personalProgress.amountRaised / $scope.personalProgress.goal) * 100);
          }
          if (percent > 100) {
            percent = 100;
          }
          $scope.personalProgress.percent = percent;
          if (!$scope.$$phase) {
            return $scope.$apply();
          }
        }, 500);
      };
      TeamraiserParticipantService.getParticipants('fr_id=' + $scope.frId + '&first_name=' + encodeURIComponent('%%') + '&last_name=' + encodeURIComponent('%') + '&list_filter_column=reg.cons_id&list_filter_text=' + $scope.participantId, {
        error: function() {
          return setParticipantProgress();
        },
        success: function(response) {
          var participantInfo, ref;
          participantInfo = (ref = response.getParticipantsResponse) != null ? ref.participant : void 0;
          if (!participantInfo) {
            return setParticipantProgress();
          } else {
            return setParticipantProgress(Number(participantInfo.amountRaised), Number(participantInfo.goal));
          }
        }
      });
      $scope.personalDonors = {
        page: 1
      };
      $defaultResponsivePersonalDonors = angular.element('.js--personal-donors .team-honor-list-row');
      if ($defaultResponsivePersonalDonors && $defaultResponsivePersonalDonors.length !== 0) {
        if ($defaultResponsivePersonalDonors.length === 1 && $defaultResponsivePersonalDonors.eq(0).find('.team-honor-list-name').length === 0) {
          $scope.personalDonors.donors = [];
          return $scope.personalDonors.totalNumber = 0;
        } else {
          angular.forEach($defaultResponsivePersonalDonors, function(personalDonor, personalDonorIndex) {
            var donorAmount, donorName;
            donorName = angular.element(personalDonor).find('.team-honor-list-name').text();
            donorAmount = angular.element(personalDonor).find('.team-honor-list-value').text();
            if (!donorAmount || donorAmount.indexOf('$') === -1) {
              donorAmount = -1;
            } else {
              donorAmount = Number(donorAmount.replace('$', '').replace(/,/g, '')) * 100;
            }
            if (!$scope.personalDonors.donors) {
              $scope.personalDonors.donors = [];
            }
            return $scope.personalDonors.donors.push({
              name: donorName,
              amount: donorAmount,
              amountFormatted: donorAmount === -1 ? '' : $filter('currency')(donorAmount / 100, '$').replace('.00', '')
            });
          });
          return $scope.personalDonors.totalNumber = $defaultResponsivePersonalDonors.length;
        }
      } else {
        $defaultPersonalDonors = angular.element('.js--personal-donors .scrollContent p');
        if (!$defaultPersonalDonors || $defaultPersonalDonors.length === 0) {
          $scope.personalDonors.donors = [];
          return $scope.personalDonors.totalNumber = 0;
        } else {
          angular.forEach($defaultPersonalDonors, function(personalDonor, personalDonorIndex) {
            var donorAmount, donorName;
            donorName = jQuery.trim(angular.element(personalDonor).html().split('<')[0]);
            donorAmount = jQuery.trim(angular.element(personalDonor).html().split('>')[1]);
            if (!donorAmount || donorAmount.indexOf('$') === -1) {
              donorAmount = -1;
            } else {
              donorAmount = Number(donorAmount.replace('$', '').replace(/,/g, '')) * 100;
            }
            if (!$scope.personalDonors.donors) {
              $scope.personalDonors.donors = [];
            }
            return $scope.personalDonors.donors.push({
              name: donorName,
              amount: donorAmount,
              amountFormatted: donorAmount === -1 ? '' : $filter('currency')(donorAmount / 100, '$').replace('.00', '')
            });
          });
          return $scope.personalDonors.totalNumber = $defaultPersonalDonors.length;
        }
      }
    }
  ]);

  angular.module('ahaLuminateControllers').controller('TeamPageCtrl', [
    '$scope', '$location', function($scope, $location) {
      return $scope.teamId = $location.absUrl().split('team_id=')[1].split('&')[0];
    }
  ]);

  angular.module('ahaLuminateApp').directive('companyParticipantList', function() {
    return {
      templateUrl: '../aha-luminate/dist/jump-hoops/html/directive/companyParticipantList.html',
      restrict: 'E',
      replace: true,
      scope: {
        companyName: '=',
        companyId: '=',
        frId: '=',
        participants: '='
      },
      controller: [
        '$scope', function($scope) {
          $scope.companyParticipantSearch = {
            participant_name: ''
          };
          return $scope.toggleCompanyParticipantList = function() {
            return $scope.isOpen = !$scope.isOpen;
          };
        }
      ]
    };
  });

  angular.module('ahaLuminateApp').directive('companyTeamList', function() {
    return {
      templateUrl: '../aha-luminate/dist/jump-hoops/html/directive/companyTeamList.html',
      restrict: 'E',
      replace: true,
      scope: {
        companyName: '=',
        companyId: '=',
        frId: '=',
        teams: '='
      },
      controller: [
        '$scope', function($scope) {
          $scope.companyTeamSearch = {
            team_name: ''
          };
          return $scope.toggleCompanyTeamList = function() {
            return $scope.isOpen = !$scope.isOpen;
          };
        }
      ]
    };
  });

}).call(this);
