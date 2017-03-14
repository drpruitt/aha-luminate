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
        return $rootScope.authToken = $dataRoot.data('auth-token');
      }
    }
  ]);

  angular.element(document).ready(function() {
    return angular.bootstrap(document, ['ahaLuminateApp']);
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

  angular.module('ahaLuminateControllers').controller('MainCtrl', [
    '$scope', function($scope) {
      return angular.element('body').on('click', '.addthis_button_facebook', function(e) {
        return e.preventDefault();
      });
    }
  ]);

}).call(this);
