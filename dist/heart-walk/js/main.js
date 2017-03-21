(function() {
  angular.module('ahaLuminateApp', ['ngSanitize', 'ui.bootstrap', 'ahaLuminateControllers']);

  angular.module('ahaLuminateControllers', []);

  angular.module('ahaLuminateApp').constant('APP_INFO', {
    version: '1.0.0',
    rootPath: (function() {
      var devBranch, rootPath;
      rootPath = '';
      devBranch = luminateExtend.global.devBranch;
      if (devBranch && devBranch !== '') {
        return rootPath = '../' + devBranch + '/aha-luminate/';
      } else {
        return rootPath = '../aha-luminate/';
      }
    })()
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

  angular.module('ahaLuminateApp').factory('CsvService', function() {
    return {
      toJson: function(csvStr) {
        var currentline, headers, i, j, lines, obj, result;
        lines = this.toArray(csvStr);
        result = [];
        headers = lines[0];
        lines.splice(0, 1);
        i = 0;
        while (i < lines.length) {
          currentline = lines[i];
          obj = {};
          if (currentline.length === headers.length) {
            j = 0;
            while (j < headers.length) {
              obj[headers[j]] = currentline[j];
              j++;
            }
            result.push(obj);
          }
          i++;
        }
        return result;
      },
      toArray: function(csvStr) {
        var arrData, arrMatches, objPattern, strDelimiter, strMatchedDelimiter, strMatchedValue;
        strDelimiter = ',';
        objPattern = new RegExp('(\\' + strDelimiter + '|\\r?\\n|\\r|^)' + '(?:"([^"]*(?:""[^"]*)*)"|' + '([^"\\' + strDelimiter + '\\r\\n]*))', 'gi');
        arrData = [[]];
        arrMatches = null;
        while (arrMatches = objPattern.exec(csvStr)) {
          strMatchedDelimiter = arrMatches[1];
          strMatchedValue = void 0;
          if (strMatchedDelimiter.length && strMatchedDelimiter !== strDelimiter) {
            arrData.push([]);
          }
          if (arrMatches[2]) {
            strMatchedValue = arrMatches[2].replace(new RegExp('""', 'g'), '"');
          } else {
            strMatchedValue = arrMatches[3];
          }
          arrData[arrData.length - 1].push(strMatchedValue);
        }
        return arrData;
      }
    };
  });

  angular.module('ahaLuminateApp').factory('DonationService', [
    'LuminateRESTService', function(LuminateRESTService) {
      return {
        getDonationFormInfo: function(requestData) {
          var dataString;
          dataString = 'method=getDonationFormInfo';
          if (requestData && requestData !== '') {
            dataString += '&' + requestData;
          }
          return LuminateRESTService.donationRequest(dataString).then(function(response) {
            return response;
          });
        },
        donate: function(requestData) {
          var dataString;
          dataString = 'method=donate';
          if (requestData && requestData !== '') {
            dataString += '&' + requestData;
          }
          return LuminateRESTService.donationRequest(dataString).then(function(response) {
            return response;
          });
        },
        startDonation: function(requestData) {
          var dataString;
          dataString = 'method=startDonation';
          if (requestData && requestData !== '') {
            dataString += '&' + requestData;
          }
          return LuminateRESTService.donationRequest(dataString).then(function(response) {
            return response;
          });
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
        donationRequest: function(requestData) {
          return this.request('CRDonationAPI', requestData);
        },
        luminateExtendConsRequest: function(requestData, includeAuth, callback) {
          return this.luminateExtendRequest('cons', requestData, includeAuth, false, callback);
        }
      };
    }
  ]);

  angular.module('ahaLuminateApp').factory('TeamraiserCompanyService', [
    'LuminateRESTService', '$http', '$sce', function(LuminateRESTService, $http, $sce) {
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
        getCoordinatorQuestion: function(coordinatorId, eventId) {
          return $http({
            method: 'GET',
            url: 'PageServer?pagename=ym_coordinator_data&pgwrap=n&consId=' + coordinatorId + '&frId=' + eventId
          }).then(function(response) {
            return response;
          });
        },
        getSchools: function(callback) {
          var url, urlSCE;
          url = 'http://www2.heart.org/site/PageServer?pagename=jump_hoops_school_search&pgwrap=n';
          urlSCE = $sce.trustAsResourceUrl(url);
          return $http.jsonp(urlSCE, {
            jsonpCallbackParam: 'callback'
          }).then(function(response) {
            if (response.data.success) {
              return callback.success(decodeURIComponent(response.data.success.schools.replace(/\+/g, ' ')));
            } else {
              return callback.failure(response);
            }
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

  angular.module('ahaLuminateApp').factory('UtilsService', function() {
    return {
      unique: function(arr) {
        var i, n, r;
        n = {};
        r = [];
        i = 0;
        while (i < arr.length) {
          if (!n[arr[i]]) {
            n[arr[i]] = true;
            r.push(arr[i]);
          }
          i++;
        }
        return r;
      }
    };
  });

  angular.module('ahaLuminateApp').factory('ZuriService', [
    '$rootScope', '$http', '$sce', function($rootScope, $http, $sce) {
      return {
        getZooStudent: function(requestData, callback) {
          var url, urlSCE;
          url = 'http://hearttools.heart.org/zoocrew-api/student/' + requestData + '?key=6Mwqh5dFV39HLDq7';
          urlSCE = $sce.trustAsResourceUrl(url);
          return $http.jsonp(urlSCE, {
            jsonpCallbackParam: 'callback'
          }).then(function(response) {
            if (response.data.success === false) {
              return callback.error(response);
            } else {
              return callback.success(response);
            }
          });
        },
        getZooSchool: function(requestData, callback) {
          var url, urlSCE;
          url = 'http://hearttools.heart.org/zoocrew-api/program/' + requestData + '?key=6Mwqh5dFV39HLDq7';
          urlSCE = $sce.trustAsResourceUrl(url);
          return $http.jsonp(urlSCE, {
            jsonpCallbackParam: 'callback'
          }).then(function(response) {
            if (response.data.success === false) {
              return callback.error(response);
            } else {
              return callback.success(response);
            }
          });
        }
      };
    }
  ]);

  angular.module('ahaLuminateApp').factory('TeamraiserCompanyDataService', [
    '$rootScope', '$http', function($rootScope, $http) {
      return {
        getCompanyData: function() {
          return $http.get('PageServer?pagename=getHeartwalkCompanyData&pgwrap=n&response_format=json&fr_id=' + $rootScope.frId).then(function(response) {
            return response;
          });
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

  angular.module('ahaLuminateApp').directive('companyParticipantList', [
    'APP_INFO', function(APP_INFO) {
      return {
        templateUrl: APP_INFO.rootPath + 'dist/heart-walk/html/directive/companyParticipantList.html',
        restrict: 'E',
        replace: true,
        scope: {
          isOpen: '=',
          isChildCompany: '=',
          companyName: '=',
          companyId: '=',
          frId: '=',
          participants: '=',
          searchCompanyParticipants: '='
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
    }
  ]);

  angular.module('ahaLuminateApp').directive('companyTeamList', [
    'APP_INFO', function(APP_INFO) {
      return {
        templateUrl: APP_INFO.rootPath + 'dist/heart-walk/html/directive/companyTeamList.html',
        restrict: 'E',
        replace: true,
        scope: {
          isOpen: '=',
          isChildCompany: '=',
          companyName: '=',
          companyId: '=',
          frId: '=',
          teams: '=',
          searchCompanyTeams: '='
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
    }
  ]);

  angular.module('ahaLuminateApp').directive('teamMemberList', [
    'APP_INFO', function(APP_INFO) {
      return {
        templateUrl: APP_INFO.rootPath + 'dist/heart-walk/html/directive/teamMemberList.html',
        restrict: 'E',
        replace: true,
        scope: {
          teamMembers: '=',
          teamGiftsLabel: '=',
          teamGiftsAmount: '=',
          teamGiftsAmountFormatted: '='
        }
      };
    }
  ]);

  angular.module('ahaLuminateApp').directive('topCompanyList', [
    'APP_INFO', function(APP_INFO) {
      return {
        templateUrl: APP_INFO.rootPath + 'dist/heart-walk/html/directive/topCompanyList.html',
        restrict: 'E',
        replace: true,
        scope: {
          companies: '=',
          maxSize: '='
        }
      };
    }
  ]);

  angular.module('ahaLuminateApp').directive('topParticipantList', [
    'APP_INFO', function(APP_INFO) {
      return {
        templateUrl: APP_INFO.rootPath + 'dist/heart-walk/html/directive/topParticipantList.html',
        restrict: 'E',
        replace: true,
        scope: {
          participants: '=',
          maxSize: '='
        }
      };
    }
  ]);

  angular.module('ahaLuminateApp').directive('topTeamList', [
    'APP_INFO', function(APP_INFO) {
      return {
        templateUrl: APP_INFO.rootPath + 'dist/heart-walk/html/directive/topTeamList.html',
        restrict: 'E',
        replace: true,
        scope: {
          teams: '=',
          maxSize: '='
        }
      };
    }
  ]);

  angular.module('ahaLuminateControllers').controller('CompanyListPageCtrl', [
    '$scope', '$filter', 'TeamraiserCompanyDataService', function($scope, $filter, TeamraiserCompanyDataService) {
      $scope.topCompanies = {
        'ng_sort_column': null,
        'ng_sort_reverse': null
      };
      $scope.sortCompanyList = function(column) {
        if ($scope.topCompanies.ng_sort_column === column && $scope.topCompanies.ng_sort_reverse === false) {
          $scope.topCompanies.ng_sort_reverse = true;
        } else {
          $scope.topCompanies.ng_sort_reverse = false;
        }
        $scope.topCompanies.companies = $filter('orderBy')($scope.topCompanies.companies, column, $scope.topCompanies.ng_sort_reverse);
        return $scope.topCompanies.ng_sort_column = column;
      };
      return TeamraiserCompanyDataService.getCompanyData().then(function(response) {
        var companies, csvToArray, ref, topCompanies;
        companies = (ref = response.data.getCompanyDataResponse) != null ? ref.company : void 0;
        if (!companies) {
          return $scope.topCompanies.companies = [];
        } else {
          topCompanies = [];
          csvToArray = function(strData) {
            var arrData, arrMatches, objPattern, strDelimiter, strMatchedDelimiter, strMatchedValue;
            strDelimiter = ',';
            objPattern = new RegExp("(\\" + strDelimiter + "|\\r?\\n|\\r|^)" + "(?:\"([^\"]*(?:\"\"[^\"]*)*)\"|" + "([^\"\\" + strDelimiter + "\\r\\n]*))", "gi");
            arrData = [[]];
            arrMatches = null;
            while (arrMatches = objPattern.exec(strData)) {
              strMatchedDelimiter = arrMatches[1];
              strMatchedValue = void 0;
              if (strMatchedDelimiter.length && strMatchedDelimiter !== strDelimiter) {
                arrData.push([]);
              }
              if (arrMatches[2]) {
                strMatchedValue = arrMatches[2].replace(new RegExp("\"\"", "g"), "\"");
              } else {
                strMatchedValue = arrMatches[3];
              }
              arrData[arrData.length - 1].push(strMatchedValue);
            }
            return arrData;
          };
          angular.forEach(companies, function(company) {
            var companyData;
            if (company !== '') {
              companyData = csvToArray(company)[0];
              return topCompanies.push({
                "eventId": $scope.frId,
                "companyId": companyData[0],
                "participantCount": Number(companyData[3]),
                "companyName": companyData[1],
                "teamCount": Number(companyData[4]),
                "amountRaised": Number(companyData[2]) * 100,
                "amountRaisedFormatted": $filter('currency')(Number(companyData[2]), '$', 0)
              });
            }
          });
          $scope.topCompanies.companies = topCompanies;
          return $scope.sortCompanyList('companyName');
        }
      });
    }
  ]);

  angular.module('ahaLuminateControllers').controller('CompanyPageCtrl', [
    '$scope', '$location', '$filter', '$timeout', 'TeamraiserCompanyService', 'TeamraiserTeamService', 'TeamraiserParticipantService', function($scope, $location, $filter, $timeout, TeamraiserCompanyService, TeamraiserTeamService, TeamraiserParticipantService) {
      var $childCompanyAmounts, $childCompanyLinks, $defaultCompanyHierarchy, $defaultCompanySummary, addChildCompanyParticipants, addChildCompanyTeams, companyGiftCount, numCompanies, setCompanyFundraisingProgress, setCompanyNumParticipants, setCompanyNumTeams, setCompanyParticipants, setCompanyTeams, totalCompanyAmountRaised;
      $scope.companyId = $location.absUrl().split('company_id=')[1].split('&')[0];
      $defaultCompanyHierarchy = angular.element('.js--default-company-hierarchy');
      $childCompanyAmounts = $defaultCompanyHierarchy.find('.trr-td p.righted');
      totalCompanyAmountRaised = 0;
      angular.forEach($childCompanyAmounts, function(childCompanyAmount) {
        var amountRaised;
        amountRaised = angular.element(childCompanyAmount).text();
        if (amountRaised) {
          amountRaised = amountRaised.replace('$', '').replace(/,/g, '');
          amountRaised = Number(amountRaised) * 100;
          return totalCompanyAmountRaised += amountRaised;
        }
      });
      $defaultCompanySummary = angular.element('.js--default-company-summary');
      companyGiftCount = $defaultCompanySummary.find('.company-tally-container--gift-count .company-tally-ammount').text();
      if (companyGiftCount === '') {
        companyGiftCount = '0';
      }
      $scope.companyProgress = {
        numDonations: companyGiftCount
      };
      setCompanyFundraisingProgress = function(amountRaised, goal) {
        $scope.companyProgress.amountRaised = amountRaised || 0;
        $scope.companyProgress.amountRaised = Number($scope.companyProgress.amountRaised);
        $scope.companyProgress.amountRaisedFormatted = $filter('currency')($scope.companyProgress.amountRaised / 100, '$', 0);
        $scope.companyProgress.goal = goal || 0;
        $scope.companyProgress.goal = Number($scope.companyProgress.goal);
        $scope.companyProgress.goalFormatted = $filter('currency')($scope.companyProgress.goal / 100, '$', 0);
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
      TeamraiserCompanyService.getCompanies('company_id=' + $scope.companyId, {
        error: function() {
          return setCompanyFundraisingProgress();
        },
        success: function(response) {
          var companyInfo, ref;
          companyInfo = (ref = response.getCompaniesResponse) != null ? ref.company : void 0;
          if (companyInfo == null) {
            return setCompanyFundraisingProgress();
          } else {
            return setCompanyFundraisingProgress(totalCompanyAmountRaised, companyInfo.goal);
          }
        }
      });
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
      $scope.companyTeamSearch = {
        team_name: ''
      };
      $scope.companyTeams = {
        isOpen: true,
        page: 1
      };
      setCompanyTeams = function(teams, totalNumber) {
        $scope.companyTeams.teams = teams || [];
        totalNumber = totalNumber || 0;
        $scope.companyTeams.totalNumber = Number(totalNumber);
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
          isOpen: true,
          page: pageNumber,
          companyIndex: companyIndex,
          companyId: companyId || '',
          companyName: companyName || '',
          teams: teams || []
        };
        totalNumber = totalNumber || 0;
        $scope.childCompanyTeams.companies[companyIndex].totalNumber = Number(totalNumber);
        if (!$scope.$$phase) {
          return $scope.$apply();
        }
      };
      setCompanyNumTeams = function(numTeams) {
        if (!$scope.companyProgress.numTeams) {
          $scope.companyProgress.numTeams = numTeams || 0;
        }
        if (!$scope.$$phase) {
          return $scope.$apply();
        }
      };
      $scope.getCompanyTeamLists = function() {
        var numCompaniesTeamRequestComplete, numTeams;
        numCompaniesTeamRequestComplete = 0;
        numTeams = 0;
        $scope.getCompanyTeams = function() {
          var pageNumber;
          pageNumber = $scope.companyTeams.page - 1;
          return TeamraiserTeamService.getTeams('team_company_id=' + $scope.companyId + '&team_name=' + $scope.companyTeamSearch.team_name + '&list_sort_column=total&list_ascending=false&list_page_size=5&list_page_offset=' + pageNumber, {
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
              if (companyTeams != null) {
                if (!angular.isArray(companyTeams)) {
                  companyTeams = [companyTeams];
                }
                angular.forEach(companyTeams, function(companyTeam) {
                  var joinTeamURL;
                  companyTeam.amountRaised = Number(companyTeam.amountRaised);
                  companyTeam.amountRaisedFormatted = $filter('currency')(companyTeam.amountRaised / 100, '$', 0);
                  joinTeamURL = companyTeam.joinTeamURL;
                  if (joinTeamURL != null) {
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
          return TeamraiserTeamService.getTeams('team_company_id=' + childCompanyId + '&team_name=' + $scope.companyTeamSearch.team_name + '&list_sort_column=total&list_ascending=false&list_page_size=5&list_page_offset=' + pageNumber, {
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
              if (companyTeams == null) {
                addChildCompanyTeams(childCompanyIndex, childCompanyId, childCompanyName);
              } else {
                if (!angular.isArray(companyTeams)) {
                  companyTeams = [companyTeams];
                }
                angular.forEach(companyTeams, function(companyTeam) {
                  var joinTeamURL;
                  companyTeam.amountRaised = Number(companyTeam.amountRaised);
                  companyTeam.amountRaisedFormatted = $filter('currency')(companyTeam.amountRaised / 100, '$', 0);
                  joinTeamURL = companyTeam.joinTeamURL;
                  if (joinTeamURL != null) {
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
        return angular.forEach($scope.childCompanies, function(childCompany, childCompanyIndex) {
          return $scope.getChildCompanyTeams(childCompanyIndex);
        });
      };
      $scope.getCompanyTeamLists();
      $scope.searchCompanyTeams = function(companyTeamSearch) {
        $scope.companyTeamSearch.team_name = (companyTeamSearch != null ? companyTeamSearch.team_name : void 0) || '';
        $scope.companyTeams.isOpen = true;
        $scope.companyTeams.page = 1;
        angular.forEach($scope.childCompanyTeams.companies, function(company, companyIndex) {
          $scope.childCompanyTeams.companies[companyIndex].isOpen = true;
          return $scope.childCompanyTeams.companies[companyIndex].page = 1;
        });
        return $scope.getCompanyTeamLists();
      };
      $scope.companyParticipantSearch = {
        participant_name: ''
      };
      $scope.companyParticipants = {
        isOpen: true,
        page: 1
      };
      setCompanyParticipants = function(participants, totalNumber) {
        $scope.companyParticipants.participants = participants || [];
        totalNumber = totalNumber || 0;
        $scope.companyParticipants.totalNumber = Number(totalNumber);
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
          isOpen: true,
          page: pageNumber,
          companyIndex: companyIndex,
          companyId: companyId || '',
          companyName: companyName || '',
          participants: participants || []
        };
        totalNumber = totalNumber || 0;
        $scope.childCompanyParticipants.companies[companyIndex].totalNumber = Number(totalNumber);
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
      $scope.getCompanyParticipantLists = function() {
        var numCompaniesParticipantRequestComplete, numParticipants;
        numCompaniesParticipantRequestComplete = 0;
        numParticipants = 0;
        $scope.getCompanyParticipants = function() {
          var firstName, lastName, pageNumber;
          firstName = $scope.companyParticipantSearch.participant_name;
          lastName = '';
          if ($scope.companyParticipantSearch.participant_name.indexOf(' ') !== -1) {
            firstName = $scope.companyParticipantSearch.participant_name.split(' ')[0];
            lastName = $scope.companyParticipantSearch.participant_name.split(' ')[1];
          }
          pageNumber = $scope.companyParticipants.page - 1;
          return TeamraiserParticipantService.getParticipants('team_name=' + encodeURIComponent('%%%') + '&first_name=' + firstName + '&last_name=' + lastName + '&list_filter_column=team.company_id&list_filter_text=' + $scope.companyId + '&list_sort_column=total&list_ascending=false&list_page_size=5&list_page_offset=' + pageNumber, {
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
              if (participants != null) {
                if (!angular.isArray(participants)) {
                  participants = [participants];
                }
                companyParticipants = [];
                angular.forEach(participants, function(participant) {
                  var donationUrl, ref1;
                  if ((ref1 = participant.name) != null ? ref1.first : void 0) {
                    participant.amountRaised = Number(participant.amountRaised);
                    participant.amountRaisedFormatted = $filter('currency')(participant.amountRaised / 100, '$', 0);
                    donationUrl = participant.donationUrl;
                    if (donationUrl != null) {
                      participant.donationUrl = donationUrl.split('/site/')[1];
                    }
                    return companyParticipants.push(participant);
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
          var childCompany, childCompanyId, childCompanyName, firstName, lastName, pageNumber, ref;
          childCompany = $scope.childCompanies[childCompanyIndex];
          childCompanyId = childCompany.id;
          childCompanyName = childCompany.name;
          firstName = $scope.companyParticipantSearch.participant_name;
          lastName = '';
          if ($scope.companyParticipantSearch.participant_name.indexOf(' ') !== -1) {
            firstName = $scope.companyParticipantSearch.participant_name.split(' ')[0];
            lastName = $scope.companyParticipantSearch.participant_name.split(' ')[1];
          }
          pageNumber = (ref = $scope.childCompanyParticipants.companies[childCompanyIndex]) != null ? ref.page : void 0;
          if (!pageNumber) {
            pageNumber = 0;
          } else {
            pageNumber--;
          }
          return TeamraiserParticipantService.getParticipants('team_name=' + encodeURIComponent('%%%') + '&first_name=' + firstName + '&last_name=' + lastName + '&list_filter_column=team.company_id&list_filter_text=' + childCompanyId + '&list_sort_column=total&list_ascending=false&list_page_size=5&list_page_offset=' + pageNumber, {
            error: function() {
              addChildCompanyParticipants(childCompanyIndex, childCompanyId, childCompanyName);
              numCompaniesParticipantRequestComplete++;
              if (numCompaniesParticipantRequestComplete === numCompanies) {
                return setCompanyNumParticipants(numParticipants);
              }
            },
            success: function(response) {
              var companyParticipants, participants, ref1, totalNumberParticipants;
              participants = (ref1 = response.getParticipantsResponse) != null ? ref1.participant : void 0;
              if (participants == null) {
                addChildCompanyParticipants(childCompanyIndex, childCompanyId, childCompanyName);
              } else {
                if (!angular.isArray(participants)) {
                  participants = [participants];
                }
                companyParticipants = [];
                angular.forEach(participants, function(participant) {
                  var donationUrl, ref2;
                  if ((ref2 = participant.name) != null ? ref2.first : void 0) {
                    participant.amountRaised = Number(participant.amountRaised);
                    participant.amountRaisedFormatted = $filter('currency')(participant.amountRaised / 100, '$', 0);
                    donationUrl = participant.donationUrl;
                    if (donationUrl != null) {
                      participant.donationUrl = donationUrl.split('/site/')[1];
                    }
                    return companyParticipants.push(participant);
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
      };
      $scope.getCompanyParticipantLists();
      return $scope.searchCompanyParticipants = function(companyParticipantSearch) {
        $scope.companyParticipantSearch.participant_name = (companyParticipantSearch != null ? companyParticipantSearch.participant_name : void 0) || '';
        $scope.companyParticipants.isOpen = true;
        $scope.companyParticipants.page = 1;
        angular.forEach($scope.childCompanyParticipants.companies, function(company, companyIndex) {
          $scope.childCompanyParticipants.companies[companyIndex].isOpen = true;
          return $scope.childCompanyParticipants.companies[companyIndex].page = 1;
        });
        return $scope.getCompanyParticipantLists();
      };
    }
  ]);

  angular.module('ahaLuminateControllers').controller('GreetingPageCtrl', [
    '$scope', '$http', '$timeout', '$filter', 'TeamraiserParticipantService', 'TeamraiserTeamService', 'TeamraiserCompanyDataService', function($scope, $http, $timeout, $filter, TeamraiserParticipantService, TeamraiserTeamService, TeamraiserCompanyDataService) {
      var setTopParticipants, setTopTeams;
      $http.get('PageServer?pagename=getTeamraiserInfo&fr_id=' + $scope.frId + '&response_format=json&pgwrap=n').then(function(response) {
        var teamraiserInfo;
        teamraiserInfo = response.data.getTeamraiserInfo;
        if (!teamraiserInfo) {
          $scope.eventProgress = {
            amountRaised: 0,
            goal: 0
          };
        } else {
          $scope.eventProgress = {
            amountRaised: teamraiserInfo.amountRaised,
            goal: teamraiserInfo.goal
          };
        }
        $scope.eventProgress.percent = 2;
        return $timeout(function() {
          var percent;
          percent = $scope.eventProgress.percent;
          if ($scope.eventProgress.goal !== 0) {
            percent = Math.ceil(($scope.eventProgress.amountRaised / $scope.eventProgress.goal) * 100);
          }
          if (percent < 2) {
            percent = 2;
          }
          if (percent > 98) {
            percent = 98;
          }
          return $scope.eventProgress.percent = percent;
        }, 500);
      });
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
          var participants, ref, topParticipants;
          participants = ((ref = response.getParticipantsResponse) != null ? ref.participant : void 0) || [];
          if (!participants) {
            return setTopParticipants([]);
          } else {
            if (!angular.isArray(participants)) {
              participants = [participants];
            }
            topParticipants = [];
            angular.forEach(participants, function(participant) {
              var ref1;
              if ((ref1 = participant.name) != null ? ref1.first : void 0) {
                participant.amountRaised = Number(participant.amountRaised);
                participant.amountRaisedFormatted = $filter('currency')(participant.amountRaised / 100, '$', 0);
                return topParticipants.push(participant);
              }
            });
            return setTopParticipants(topParticipants);
          }
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
          var ref, teams, topTeams;
          teams = ((ref = response.getTeamSearchByInfoResponse) != null ? ref.team : void 0) || [];
          if (!teams) {
            return setTopTeams([]);
          } else {
            if (!angular.isArray(teams)) {
              teams = [teams];
            }
            topTeams = [];
            angular.forEach(teams, function(team) {
              team.amountRaised = Number(team.amountRaised);
              team.amountRaisedFormatted = $filter('currency')(team.amountRaised / 100, '$', 0);
              return topTeams.push(team);
            });
            return setTopTeams(topTeams);
          }
        }
      });
      $scope.topCompanies = {};
      return TeamraiserCompanyDataService.getCompanyData().then(function(response) {
        var companies, csvToArray, ref, topCompanies;
        companies = (ref = response.data.getCompanyDataResponse) != null ? ref.company : void 0;
        if (!companies) {
          return $scope.topCompanies.companies = [];
        } else {
          topCompanies = [];
          csvToArray = function(strData) {
            var arrData, arrMatches, objPattern, strDelimiter, strMatchedDelimiter, strMatchedValue;
            strDelimiter = ',';
            objPattern = new RegExp("(\\" + strDelimiter + "|\\r?\\n|\\r|^)" + "(?:\"([^\"]*(?:\"\"[^\"]*)*)\"|" + "([^\"\\" + strDelimiter + "\\r\\n]*))", "gi");
            arrData = [[]];
            arrMatches = null;
            while (arrMatches = objPattern.exec(strData)) {
              strMatchedDelimiter = arrMatches[1];
              strMatchedValue = void 0;
              if (strMatchedDelimiter.length && strMatchedDelimiter !== strDelimiter) {
                arrData.push([]);
              }
              if (arrMatches[2]) {
                strMatchedValue = arrMatches[2].replace(new RegExp("\"\"", "g"), "\"");
              } else {
                strMatchedValue = arrMatches[3];
              }
              arrData[arrData.length - 1].push(strMatchedValue);
            }
            return arrData;
          };
          angular.forEach(companies, function(company) {
            var companyData;
            if (company !== '') {
              companyData = csvToArray(company)[0];
              return topCompanies.push({
                "eventId": $scope.frId,
                "companyId": companyData[0],
                "participantCount": companyData[3],
                "companyName": companyData[1],
                "teamCount": companyData[4],
                "amountRaised": Number(companyData[2]) * 100,
                "amountRaisedFormatted": $filter('currency')(Number(companyData[2]), '$', 0)
              });
            }
          });
          return $scope.topCompanies.companies = $filter('orderBy')(topCompanies, 'amountRaised', true);
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

  angular.module('ahaLuminateControllers').controller('PersonalPageCtrl', [
    '$scope', '$location', '$timeout', 'TeamraiserParticipantService', function($scope, $location, $timeout, TeamraiserParticipantService) {
      var setParticipantFundraisingProgress;
      $scope.participantId = $location.absUrl().split('px=')[1].split('&')[0];
      $scope.participantProgress = {};
      setParticipantFundraisingProgress = function(amountRaised, goal) {
        $scope.participantProgress.amountRaised = amountRaised || 0;
        $scope.participantProgress.amountRaised = Number($scope.participantProgress.amountRaised);
        $scope.participantProgress.goal = goal || 0;
        $scope.participantProgress.percent = 2;
        $timeout(function() {
          var percent;
          percent = $scope.participantProgress.percent;
          if ($scope.participantProgress.goal !== 0) {
            percent = Math.ceil(($scope.participantProgress.amountRaised / $scope.participantProgress.goal) * 100);
          }
          if (percent < 2) {
            percent = 2;
          }
          if (percent > 98) {
            percent = 98;
          }
          $scope.participantProgress.percent = percent;
          if (!$scope.$$phase) {
            return $scope.$apply();
          }
        }, 500);
        if (!$scope.$$phase) {
          return $scope.$apply();
        }
      };
      return TeamraiserParticipantService.getParticipants('first_name=' + encodeURIComponent('%%%') + '&list_filter_column=reg.cons_id&list_filter_text=' + $scope.participantId, {
        error: function() {
          return setParticipantFundraisingProgress();
        },
        success: function(response) {
          var participantInfo, ref;
          participantInfo = (ref = response.getParticipantsResponse) != null ? ref.participant : void 0;
          if (!participantInfo) {
            return setParticipantFundraisingProgress();
          } else {
            return setParticipantFundraisingProgress(participantInfo.amountRaised, participantInfo.goal);
          }
        }
      });
    }
  ]);

  angular.module('ahaLuminateControllers').controller('TeamPageCtrl', [
    '$scope', '$location', '$timeout', '$filter', 'TeamraiserTeamService', 'TeamraiserParticipantService', function($scope, $location, $timeout, $filter, TeamraiserTeamService, TeamraiserParticipantService) {
      var $defaultTeamRoster, $teamGiftsRow, setTeamFundraisingProgress, setTeamMembers, teamGiftsAmount;
      $scope.teamId = $location.absUrl().split('team_id=')[1].split('&')[0];
      $scope.teamProgress = {};
      setTeamFundraisingProgress = function(amountRaised, goal) {
        $scope.teamProgress.amountRaised = amountRaised || 0;
        $scope.teamProgress.amountRaised = Number($scope.teamProgress.amountRaised);
        $scope.teamProgress.goal = goal || 0;
        $scope.teamProgress.percent = 2;
        $timeout(function() {
          var percent;
          percent = $scope.teamProgress.percent;
          if ($scope.teamProgress.goal !== 0) {
            percent = Math.ceil(($scope.teamProgress.amountRaised / $scope.teamProgress.goal) * 100);
          }
          if (percent < 2) {
            percent = 2;
          }
          if (percent > 98) {
            percent = 98;
          }
          $scope.teamProgress.percent = percent;
          if (!$scope.$$phase) {
            return $scope.$apply();
          }
        }, 500);
        if (!$scope.$$phase) {
          return $scope.$apply();
        }
      };
      TeamraiserTeamService.getTeams('team_id=' + $scope.teamId, {
        error: function() {
          return setTeamFundraisingProgress();
        },
        success: function(response) {
          var ref, teamInfo;
          teamInfo = (ref = response.getTeamSearchByInfoResponse) != null ? ref.team : void 0;
          if (!teamInfo) {
            return setTeamFundraisingProgress();
          } else {
            return setTeamFundraisingProgress(teamInfo.amountRaised, teamInfo.goal);
          }
        }
      });
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
      $scope.teamMembers.teamGiftsAmount = Number($scope.teamMembers.teamGiftsAmount);
      $scope.teamMembers.teamGiftsAmountFormatted = $filter('currency')($scope.teamMembers.teamGiftsAmount / 100, '$', 0);
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
            if (teamParticipants != null) {
              if (!angular.isArray(teamParticipants)) {
                teamParticipants = [teamParticipants];
              }
              teamMembers = [];
              angular.forEach(teamParticipants, function(teamParticipant) {
                var donationUrl, ref1;
                if ((ref1 = teamParticipant.name) != null ? ref1.first : void 0) {
                  teamParticipant.amountRaised = Number(teamParticipant.amountRaised);
                  teamParticipant.amountRaisedFormatted = $filter('currency')(teamParticipant.amountRaised / 100, '$', 0);
                  donationUrl = teamParticipant.donationUrl;
                  if (donationUrl != null) {
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
