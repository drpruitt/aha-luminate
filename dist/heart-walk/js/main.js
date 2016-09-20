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
    var appModules, error, error1, error2;
    appModules = ['ahaLuminateApp'];
    try {
      angular.module('trPcApp');
      appModules.push('trPcApp');
    } catch (error1) {
      error = error1;
    }
    try {
      angular.module('trPageEditApp');
      appModules.push('trPageEditApp');
    } catch (error2) {
      error = error2;
    }
    return angular.bootstrap(document, appModules);
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
        },
        getCompanyList: function(requestData, callback) {
          var dataString;
          dataString = 'method=getCompanyList';
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
            angular.element(element).siblings('[eq-column-height]').css('height', '');
            columnHeight = Number(angular.element(element).css('height').replace('px', ''));
            angular.element(element).siblings('[eq-column-height]').each(function() {
              var siblingHeight;
              siblingHeight = Number(angular.element(this).css('height').replace('px', ''));
              if (siblingHeight > columnHeight) {
                return columnHeight = siblingHeight;
              }
            });
            angular.element(element).css('height', columnHeight + 'px');
            return angular.element(element).siblings('[eq-column-height]').css('height', columnHeight + 'px');
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

  angular.module('ahaLuminateApp').directive('companyParticipantList', function() {
    return {
      templateUrl: '../aha-luminate/dist/heart-walk/html/directive/companyParticipantList.html',
      restrict: 'E',
      replace: true,
      scope: {
        isChildCompany: '=',
        companyName: '=',
        participants: '='
      }
    };
  });

  angular.module('ahaLuminateApp').directive('companyTeamList', function() {
    return {
      templateUrl: '../aha-luminate/dist/heart-walk/html/directive/companyTeamList.html',
      restrict: 'E',
      replace: true,
      scope: {
        isChildCompany: '=',
        companyName: '=',
        teams: '='
      }
    };
  });

  angular.module('ahaLuminateApp').directive('teamMemberList', function() {
    return {
      templateUrl: '../aha-luminate/dist/heart-walk/html/directive/teamMemberList.html',
      restrict: 'E',
      replace: true,
      scope: {
        teamMembers: '=',
        teamGiftsLabel: '=',
        teamGiftsAmount: '='
      }
    };
  });

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

  angular.module('ahaLuminateControllers').controller('CompanyPageCtrl', [
    '$scope', '$location', 'TeamraiserCompanyService', 'TeamraiserTeamService', 'TeamraiserParticipantService', function($scope, $location, TeamraiserCompanyService, TeamraiserTeamService, TeamraiserParticipantService) {
      var $childCompanyLinks, $defaultCompanyHierarchy, $defaultCompanySummary, addChildCompanyParticipants, addChildCompanyTeams, companyGiftCount, numCompanies, numCompaniesParticipantRequestComplete, numCompaniesTeamRequestComplete, numParticipants, numTeams, setCompanyFundraisingProgress, setCompanyNumParticipants, setCompanyNumTeams, setCompanyParticipants, setCompanyTeams;
      $scope.companyId = $location.absUrl().split('company_id=')[1].split('&')[0];
      $defaultCompanySummary = angular.element('.js--default-company-summary');
      companyGiftCount = $defaultCompanySummary.find('.company-tally-container--gift-count .company-tally-ammount').text();
      if (companyGiftCount === '') {
        companyGiftCount = '0';
      }
      $scope.companyProgress = {
        numDonations: companyGiftCount
      };
      setCompanyFundraisingProgress = function(amountRaised, goal) {
        $scope.companyProgress.amountRaised = amountRaised || '0';
        $scope.companyProgress.goal = goal || '0';
        if (!$scope.$$phase) {
          return $scope.$apply();
        }
      };
      TeamraiserCompanyService.getCompanies('company_id=' + $scope.companyId, {
        error: function() {
          return setCompanyFundraisingProgress();
        },
        success: function(response) {
          var companyInfo, ref;
          companyInfo = (ref = response.getCompaniesResponse) != null ? ref.company : void 0;
          if (!companyInfo) {
            return setCompanyFundraisingProgress();
          } else {
            return setCompanyFundraisingProgress(companyInfo.amountRaised, companyInfo.goal);
          }
        }
      });
      $defaultCompanyHierarchy = angular.element('.js--default-company-hierarchy');
      $childCompanyLinks = $defaultCompanyHierarchy.find('.trr-td a');
      $scope.childCompanies = [];
      angular.forEach($childCompanyLinks, function(childCompanyLink) {
        var childCompanyName, childCompanyUrl;
        childCompanyUrl = angular.element(childCompanyLink).attr('href');
        childCompanyName = angular.element(childCompanyLink).text();
        if (childCompanyUrl.indexOf('company_id=') !== -1) {
          return $scope.childCompanies.push({
            id: childCompanyUrl.split('company_id=')[1].split('&')[0],
            name: childCompanyName
          });
        }
      });
      numCompanies = $scope.childCompanies.length + 1;
      $scope.companyTeams = {
        page: 1
      };
      setCompanyTeams = function(teams, totalNumber) {
        $scope.companyTeams.teams = teams || [];
        $scope.companyTeams.totalNumber = totalNumber || 0;
        if (!$scope.$$phase) {
          return $scope.$apply();
        }
      };
      $scope.childCompanyTeams = {
        companies: []
      };
      addChildCompanyTeams = function(companyIndex, companyId, companyName, teams, totalNumber) {
        var pageNumber, ref;
        pageNumber = ((ref = $scope.childCompanyTeams.companies[companyIndex]) != null ? ref.page : void 0) || 0;
        $scope.childCompanyTeams.companies[companyIndex] = {
          page: pageNumber,
          companyIndex: companyIndex,
          companyId: companyId || '',
          companyName: companyName || '',
          teams: teams || [],
          totalNumber: totalNumber || 0
        };
        if (!$scope.$$phase) {
          return $scope.$apply();
        }
      };
      setCompanyNumTeams = function(numTeams) {
        $scope.companyProgress.numTeams = numTeams || 0;
        if (!$scope.$$phase) {
          return $scope.$apply();
        }
      };
      numCompaniesTeamRequestComplete = 0;
      numTeams = 0;
      $scope.getCompanyTeams = function() {
        var pageNumber;
        pageNumber = $scope.companyTeams.page - 1;
        return TeamraiserTeamService.getTeams('team_company_id=' + $scope.companyId + '&list_sort_column=total&list_ascending=false&list_page_size=5&list_page_offset=' + pageNumber, {
          error: function() {
            setCompanyTeams();
            numCompaniesTeamRequestComplete++;
            if (numCompaniesTeamRequestComplete === numCompanies) {
              return setCompanyNumTeams(numTeams);
            }
          },
          success: function(response) {
            var companyTeams, ref, totalNumberTeams;
            setCompanyTeams();
            companyTeams = (ref = response.getTeamSearchByInfoResponse) != null ? ref.team : void 0;
            if (companyTeams) {
              if (!angular.isArray(companyTeams)) {
                companyTeams = [companyTeams];
              }
              angular.forEach(companyTeams, function(companyTeam) {
                var joinTeamURL;
                joinTeamURL = companyTeam.joinTeamURL;
                if (joinTeamURL) {
                  return companyTeam.joinTeamURL = joinTeamURL.split('/site/')[1];
                }
              });
              totalNumberTeams = response.getTeamSearchByInfoResponse.totalNumberResults;
              setCompanyTeams(companyTeams, totalNumberTeams);
              numTeams += Number(totalNumberTeams);
            }
            numCompaniesTeamRequestComplete++;
            if (numCompaniesTeamRequestComplete === numCompanies) {
              return setCompanyNumTeams(numTeams);
            }
          }
        });
      };
      $scope.getCompanyTeams();
      $scope.getChildCompanyTeams = function(childCompanyIndex) {
        var childCompany, childCompanyId, childCompanyName, pageNumber, ref;
        childCompany = $scope.childCompanies[childCompanyIndex];
        childCompanyId = childCompany.id;
        childCompanyName = childCompany.name;
        pageNumber = (ref = $scope.childCompanyTeams.companies[childCompanyIndex]) != null ? ref.page : void 0;
        if (!pageNumber) {
          pageNumber = 0;
        } else {
          pageNumber--;
        }
        return TeamraiserTeamService.getTeams('team_company_id=' + childCompanyId + '&list_sort_column=total&list_ascending=false&list_page_size=5&list_page_offset=' + pageNumber, {
          error: function() {
            addChildCompanyTeams(childCompanyIndex, childCompanyId, childCompanyName);
            numCompaniesTeamRequestComplete++;
            if (numCompaniesTeamRequestComplete === numCompanies) {
              return setCompanyNumTeams(numTeams);
            }
          },
          success: function(response) {
            var companyTeams, ref1, totalNumberTeams;
            companyTeams = (ref1 = response.getTeamSearchByInfoResponse) != null ? ref1.team : void 0;
            if (!companyTeams) {
              addChildCompanyTeams(childCompanyIndex, childCompanyId, childCompanyName);
            } else {
              if (!angular.isArray(companyTeams)) {
                companyTeams = [companyTeams];
              }
              angular.forEach(companyTeams, function(companyTeam) {
                var joinTeamURL;
                joinTeamURL = companyTeam.joinTeamURL;
                if (joinTeamURL) {
                  return companyTeam.joinTeamURL = joinTeamURL.split('/site/')[1];
                }
              });
              totalNumberTeams = response.getTeamSearchByInfoResponse.totalNumberResults;
              addChildCompanyTeams(childCompanyIndex, childCompanyId, childCompanyName, companyTeams, totalNumberTeams);
              numTeams += Number(totalNumberTeams);
            }
            numCompaniesTeamRequestComplete++;
            if (numCompaniesTeamRequestComplete === numCompanies) {
              return setCompanyNumTeams(numTeams);
            }
          }
        });
      };
      angular.forEach($scope.childCompanies, function(childCompany, childCompanyIndex) {
        return $scope.getChildCompanyTeams(childCompanyIndex);
      });
      $scope.companyParticipants = {
        page: 1
      };
      setCompanyParticipants = function(participants, totalNumber) {
        $scope.companyParticipants.participants = participants || [];
        $scope.companyParticipants.totalNumber = totalNumber || 0;
        if (!$scope.$$phase) {
          return $scope.$apply();
        }
      };
      $scope.childCompanyParticipants = {
        companies: []
      };
      addChildCompanyParticipants = function(companyIndex, companyId, companyName, participants, totalNumber) {
        var pageNumber, ref;
        pageNumber = ((ref = $scope.childCompanyParticipants.companies[companyIndex]) != null ? ref.page : void 0) || 0;
        $scope.childCompanyParticipants.companies[companyIndex] = {
          page: pageNumber,
          companyIndex: companyIndex,
          companyId: companyId || '',
          companyName: companyName || '',
          participants: participants || [],
          totalNumber: totalNumber || 0
        };
        if (!$scope.$$phase) {
          return $scope.$apply();
        }
      };
      setCompanyNumParticipants = function(numParticipants) {
        $scope.companyProgress.numParticipants = numParticipants || 0;
        if (!$scope.$$phase) {
          return $scope.$apply();
        }
      };
      numCompaniesParticipantRequestComplete = 0;
      numParticipants = 0;
      $scope.getCompanyParticipants = function() {
        var pageNumber;
        pageNumber = $scope.companyParticipants.page - 1;
        return TeamraiserParticipantService.getParticipants('team_name=' + encodeURIComponent('%%%') + '&list_filter_column=team.company_id&list_filter_text=' + $scope.companyId + '&list_sort_column=total&list_ascending=false&list_page_size=5&list_page_offset=' + pageNumber, {
          error: function() {
            setCompanyParticipants();
            numCompaniesParticipantRequestComplete++;
            if (numCompaniesParticipantRequestComplete === numCompanies) {
              return setCompanyNumParticipants(numParticipants);
            }
          },
          success: function(response) {
            var companyParticipants, ref, totalNumberParticipants;
            setCompanyParticipants();
            companyParticipants = (ref = response.getParticipantsResponse) != null ? ref.participant : void 0;
            if (companyParticipants) {
              if (!angular.isArray(companyParticipants)) {
                companyParticipants = [companyParticipants];
              }
              angular.forEach(companyParticipants, function(companyParticipant) {
                var donationUrl;
                donationUrl = companyParticipant.donationUrl;
                if (donationUrl) {
                  return companyParticipant.donationUrl = donationUrl.split('/site/')[1];
                }
              });
              totalNumberParticipants = response.getParticipantsResponse.totalNumberResults;
              setCompanyParticipants(companyParticipants, totalNumberParticipants);
              numParticipants += Number(totalNumberParticipants);
            }
            numCompaniesParticipantRequestComplete++;
            if (numCompaniesParticipantRequestComplete === numCompanies) {
              return setCompanyNumParticipants(numParticipants);
            }
          }
        });
      };
      $scope.getCompanyParticipants();
      $scope.getChildCompanyParticipants = function(childCompanyIndex) {
        var childCompany, childCompanyId, childCompanyName, pageNumber, ref;
        childCompany = $scope.childCompanies[childCompanyIndex];
        childCompanyId = childCompany.id;
        childCompanyName = childCompany.name;
        pageNumber = (ref = $scope.childCompanyParticipants.companies[childCompanyIndex]) != null ? ref.page : void 0;
        if (!pageNumber) {
          pageNumber = 0;
        } else {
          pageNumber--;
        }
        return TeamraiserParticipantService.getParticipants('team_name=' + encodeURIComponent('%%%') + '&list_filter_column=team.company_id&list_filter_text=' + childCompanyId + '&list_sort_column=total&list_ascending=false&list_page_size=5&list_page_offset=' + pageNumber, {
          error: function() {
            addChildCompanyParticipants(childCompanyIndex, childCompanyId, childCompanyName);
            numCompaniesParticipantRequestComplete++;
            if (numCompaniesParticipantRequestComplete === numCompanies) {
              return setCompanyNumParticipants(numParticipants);
            }
          },
          success: function(response) {
            var companyParticipants, ref1, totalNumberParticipants;
            companyParticipants = (ref1 = response.getParticipantsResponse) != null ? ref1.participant : void 0;
            if (!companyParticipants) {
              addChildCompanyParticipants(childCompanyIndex, childCompanyId, childCompanyName);
            } else {
              if (!angular.isArray(companyParticipants)) {
                companyParticipants = [companyParticipants];
              }
              angular.forEach(companyParticipants, function(companyParticipant) {
                var donationUrl;
                donationUrl = companyParticipant.donationUrl;
                if (donationUrl) {
                  return companyParticipant.donationUrl = donationUrl.split('/site/')[1];
                }
              });
              totalNumberParticipants = response.getParticipantsResponse.totalNumberResults;
              addChildCompanyParticipants(childCompanyIndex, childCompanyId, childCompanyName, companyParticipants, totalNumberParticipants);
              numParticipants += Number(totalNumberParticipants);
            }
            numCompaniesParticipantRequestComplete++;
            if (numCompaniesParticipantRequestComplete === numCompanies) {
              return setCompanyNumParticipants(numParticipants);
            }
          }
        });
      };
      return angular.forEach($scope.childCompanies, function(childCompany, childCompanyIndex) {
        return $scope.getChildCompanyParticipants(childCompanyIndex);
      });
    }
  ]);

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
      return TeamraiserCompanyService.getCompanyList('include_all_companies=true', {
        error: function() {
          return setTopCompanies([]);
        },
        success: function(response) {
          var companyItems, rootAncestorCompanyIds;
          companyItems = response.getCompanyListResponse.companyItem || [];
          if (!angular.isArray(companyItems)) {
            companyItems = [companyItems];
          }
          rootAncestorCompanyIds = [];
          angular.forEach(companyItems, function(companyItem) {
            if (companyItem.parentOrgEventId === '0') {
              return rootAncestorCompanyIds.push(companyItem.companyId);
            }
          });
          return TeamraiserCompanyService.getCompanies('list_sort_column=total&list_ascending=false&list_page_size=500', {
            error: function() {
              return setTopCompanies([]);
            },
            success: function(response) {
              var companies, topCompanies;
              companies = response.getCompaniesResponse.company || [];
              if (!angular.isArray(companies)) {
                companies = [companies];
              }
              topCompanies = [];
              angular.forEach(companies, function(company) {
                if (rootAncestorCompanyIds.indexOf(company.companyId) > -1) {
                  return topCompanies.push(company);
                }
              });
              topCompanies.sort(function(a, b) {
                return Number(b.amountRaised) - Number(a.amountRaised);
              });
              return setTopCompanies(topCompanies);
            }
          });
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

  angular.module('ahaLuminateControllers').controller('PersonalPageCtrl', ['$scope', function($scope) {}]);

  angular.module('ahaLuminateControllers').controller('TeamPageCtrl', [
    '$scope', '$location', 'TeamraiserParticipantService', function($scope, $location, TeamraiserParticipantService) {
      var $defaultTeamRoster, $teamGiftsRow, setTeamMembers, teamGiftsAmount;
      $scope.teamId = $location.absUrl().split('team_id=')[1].split('&')[0];
      $scope.teamMembers = {
        page: 1
      };
      $defaultTeamRoster = angular.element('.js--default-team-roster');
      $teamGiftsRow = $defaultTeamRoster.find('.team-roster-participant-row').last();
      $scope.teamMembers.teamGiftsLabel = $teamGiftsRow.find('.team-roster-participant-name').text();
      teamGiftsAmount = $teamGiftsRow.find('.team-roster-participant-raised').text();
      if (teamGiftsAmount === '') {
        teamGiftsAmount = '0';
      }
      $scope.teamMembers.teamGiftsAmount = teamGiftsAmount.replace('$', '').replace(/,/g, '') * 100;
      setTeamMembers = function(teamMembers, totalNumber) {
        $scope.teamMembers.members = teamMembers || [];
        $scope.teamMembers.totalNumber = totalNumber || 0;
        if (!$scope.$$phase) {
          return $scope.$apply();
        }
      };
      $scope.getTeamMembers = function() {
        var pageNumber;
        pageNumber = $scope.teamMembers.page - 1;
        return TeamraiserParticipantService.getParticipants('first_name=' + encodeURIComponent('%%%') + '&list_filter_column=reg.team_id&list_filter_text=' + $scope.teamId + '&list_sort_column=total&list_ascending=false&list_page_size=4&list_page_offset=' + pageNumber, {
          error: function() {
            return setTeamMembers();
          },
          success: function(response) {
            var ref, teamMembers, teamParticipants;
            setTeamMembers();
            teamParticipants = (ref = response.getParticipantsResponse) != null ? ref.participant : void 0;
            if (teamParticipants) {
              if (!angular.isArray(teamParticipants)) {
                teamParticipants = [teamParticipants];
              }
              teamMembers = [];
              angular.forEach(teamParticipants, function(teamParticipant) {
                var donationUrl, ref1;
                if ((ref1 = teamParticipant.name) != null ? ref1.first : void 0) {
                  donationUrl = teamParticipant.donationUrl;
                  if (donationUrl) {
                    teamParticipant.donationUrl = donationUrl.split('/site/')[1];
                  }
                  return teamMembers.push(teamParticipant);
                }
              });
              return setTeamMembers(teamMembers, response.getParticipantsResponse.totalNumberResults);
            }
          }
        });
      };
      return $scope.getTeamMembers();
    }
  ]);

}).call(this);
