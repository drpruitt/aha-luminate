(function() {
  angular.module('ahaLuminateApp', ['ngSanitize', 'ngTouch', 'ui.bootstrap', 'ahaLuminateControllers']);

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

  angular.module('ahaLuminateControllers').controller('CompanyPageCtrl', [
    '$scope', '$rootScope', '$location', '$filter', '$timeout', 'TeamraiserCompanyService', 'TeamraiserTeamService', 'TeamraiserParticipantService', 'ZuriService', function($scope, $rootScope, $location, $filter, $timeout, TeamraiserCompanyService, TeamraiserTeamService, TeamraiserParticipantService, ZuriService) {
      var getCompanyParticipants, getCompanyTeams, getCompanyTotals, setCompanyFundraisingProgress, setCompanyParticipants, setCompanyTeams;
      $scope.companyId = $location.absUrl().split('company_id=')[1].split('&')[0];
      $scope.companyProgress = [];
      $rootScope.companyName = '';
      $scope.eventDate = '';
      $scope.totalTeams = '';
      $scope.teamId = '';
      $scope.studentsPledgedTotal = '';
      $scope.studentsPledgedActivityTypes = [];
      ZuriService.getZooSchool('1/1', {
        success: function(response) {
          var studentsPledgedActivities;
          console.log(response);
          $scope.studentsPledgedTotal = response.data.studentsPledged;
          studentsPledgedActivities = response.data.studentsPledgedByActivity;
          return angular.forEach(studentsPledgedActivities, function(activity) {
            return console.log(activity);
          });
        }
      });
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
          if (percent > 100) {
            percent = 100;
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
            var amountRaised, coordinatorId, eventId, goal, name;
            $scope.participantCount = response.getCompaniesResponse.company.participantCount;
            $scope.totalTeams = response.getCompaniesResponse.company.teamCount;
            eventId = response.getCompaniesResponse.company.eventId;
            amountRaised = response.getCompaniesResponse.company.amountRaised;
            goal = response.getCompaniesResponse.company.goal;
            name = response.getCompaniesResponse.company.companyName;
            coordinatorId = response.getCompaniesResponse.company.coordinatorId;
            $rootScope.companyName = name;
            setCompanyFundraisingProgress(amountRaised, goal);
            return TeamraiserCompanyService.getCoordinatorQuestion(coordinatorId, eventId).then(function(response) {
              $scope.eventDate = response.data.coordinator.event_date;
              if ($scope.totalTeams = 1) {
                return $scope.teamId = response.data.coordinator.team_id;
              }
            });
          }
        });
      };
      getCompanyTotals();
      $scope.companyTeams = [];
      setCompanyTeams = function(teams, totalNumber) {
        $scope.companyTeams.teams = teams || [];
        totalNumber = totalNumber || 0;
        $scope.companyTeams.totalNumber = Number(totalNumber);
        $scope.totalTeams = totalNumber;
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
        return TeamraiserParticipantService.getParticipants('team_name=' + encodeURIComponent('%%%') + '&first_name=' + encodeURIComponent('%%%') + '&last_name=' + encodeURIComponent('%%%') + '&list_filter_column=team.company_id&list_filter_text=' + $scope.companyId + '&list_sort_column=total&list_ascending=false&list_page_size=50', {
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

  angular.module('ahaLuminateControllers').controller('DonationCtrl', [
    '$scope', '$rootScope', 'DonationService', function($scope, $rootScope, DonationService) {
      var $donationFormRoot, billingAddressFields, donorRecognitionFields, employerMatchFields, loadForm;
      $donationFormRoot = angular.element('[data-donation-form-root]');
      $scope.donationInfo = {
        validate: 'true',
        form_id: $donationFormRoot.data('formid'),
        fr_id: $donationFormRoot.data('frid'),
        billing_text: angular.element('#billing_info_same_as_donor_row label').text()
      };
      $scope.donationLevels = [];
      $scope.giftType = function(type) {
        var checkBox;
        checkBox = angular.element('.generic-repeat-label-checkbox-container input').prop('checked');
        if (type === 'monthly') {
          if (checkBox === false) {
            angular.element('.generic-repeat-label-checkbox-container input').click();
          }
          angular.element('.ym-donation-levels__type--onetime').removeClass('btn-toggle--selected');
          return angular.element('.ym-donation-levels__type--monthly').addClass('btn-toggle--selected');
        } else {
          if (checkBox === true) {
            angular.element('.generic-repeat-label-checkbox-container input').click();
          }
          angular.element('.ym-donation-levels__type--onetime').addClass('btn-toggle--selected');
          return angular.element('.ym-donation-levels__type--monthly').removeClass('btn-toggle--selected');
        }
      };
      $scope.selectLevel = function(type, level, amount) {
        var levelAmt;
        angular.element('#pstep_finish span').remove();
        if (type === 'level') {
          levelAmt = ' <span>' + amount + ' <i class="fa fa-chevron-right" aria-hidden="true"></i></span>';
          angular.element('#pstep_finish').append(levelAmt);
        } else {
          angular.element('#pstep_finish').append('<span></span>');
        }
        angular.element('.ym-donation-levels__amount .btn-toggle.btn-toggle--selected').removeClass('btn-toggle--selected');
        angular.element('.ym-donation-levels__amount .btn-toggle.level' + level).addClass('btn-toggle--selected');
        angular.element('.ym-donation-levels__message').addClass('hidden');
        angular.element('.ym-donation-levels__message.level' + level).removeClass('hidden');
        return angular.element('.donation-level-container.level' + level + ' input').click();
      };
      $scope.enterAmount = function(amount) {
        angular.element('#pstep_finish span').text('');
        angular.element('#pstep_finish span').prepend('$' + amount);
        return angular.element('.donation-level-user-entered input').val(amount);
      };
      employerMatchFields = function() {
        angular.element('#employer_name_row').parent().addClass('ym-employer-match__fields');
        angular.element('#employer_street_row').parent().addClass('ym-employer-match__fields');
        angular.element('#employer_city_row').parent().addClass('ym-employer-match__fields');
        angular.element('#employer_state_row').parent().addClass('ym-employer-match__fields');
        angular.element('#employer_zip_row').parent().addClass('ym-employer-match__fields');
        angular.element('#employer_phone_row').parent().addClass('ym-employer-match__fields');
        return angular.element('.employer-address-container').addClass('hidden');
      };
      $scope.toggleEmployerMatch = function() {
        angular.element('.ym-employer-match__message').toggleClass('hidden');
        return angular.element('.employer-address-container').toggleClass('hidden');
      };
      donorRecognitionFields = function() {
        angular.element('#tr_show_gift_to_public_row').addClass('hidden ym-donor-recognition__fields');
        angular.element('#tr_recognition_nameanonymous_row').addClass('hidden ym-donor-recognition__fields');
        return angular.element('#tr_recognition_namerec_name_row').addClass('hidden ym-donor-recognition__fields');
      };
      $scope.toggleDonorRecognition = function() {
        return angular.element('.ym-donor-recognition__fields').toggleClass('hidden');
      };
      $scope.togglePersonalNote = function() {
        return angular.element('#tr_message_to_participant_row').toggleClass('hidden ym-border');
      };
      $scope.tributeGift = function(type) {
        if (type === 'honor') {
          angular.element('.btn-toggle--honor').toggleClass('btn-toggle--selected');
          if (angular.element('.btn-toggle--honor').hasClass('btn-toggle--selected')) {
            angular.element('.btn-toggle--memory').removeClass('btn-toggle--selected');
            angular.element('#tribute_type').val('tribute_type_value2');
            angular.element('#tribute_show_honor_fieldsname').prop('checked', true);
            return angular.element('#tribute_honoree_name_row').show();
          } else {
            angular.element('#tribute_type').val('');
            angular.element('#tribute_show_honor_fieldsname').prop('checked', false);
            return angular.element('#tribute_honoree_name_row').hide();
          }
        } else {
          angular.element('.btn-toggle--memory').toggleClass('btn-toggle--selected');
          if (angular.element('.btn-toggle--memory').hasClass('btn-toggle--selected')) {
            angular.element('.btn-toggle--honor').removeClass('btn-toggle--selected');
            angular.element('#tribute_type').val('tribute_type_value1');
            angular.element('#tribute_show_honor_fieldsname').prop('checked', true);
            return angular.element('#tribute_honoree_name_row').show();
          } else {
            angular.element('#tribute_type').val('');
            angular.element('#tribute_show_honor_fieldsname').prop('checked', false);
            return angular.element('#tribute_honoree_name_row').hide();
          }
        }
      };
      billingAddressFields = function() {
        angular.element('#billing_first_name_row').addClass('billing-info');
        angular.element('#billing_last_name_row').addClass('billing-info');
        angular.element('#billing_addr_street1_row').addClass('billing-info');
        angular.element('#billing_addr_street2_row').addClass('billing-info');
        angular.element('#billing_addr_city_row').addClass('billing-info');
        angular.element('#billing_addr_state_row').addClass('billing-info');
        angular.element('#billing_addr_zip_row').addClass('billing-info');
        angular.element('#billing_addr_country_row').addClass('billing-info');
        return angular.element('.billing-info').addClass('hidden');
      };
      $scope.toggleBillingInfo = function() {
        var inputStatus;
        angular.element('.billing-info').toggleClass('hidden');
        inputStatus = angular.element('#billing_info').prop('checked');
        if (inputStatus === true) {
          return angular.element('#billing_info_same_as_donorname').prop('checked', true);
        } else {
          return angular.element('#billing_info_same_as_donorname').prop('checked', false);
        }
      };
      loadForm = function() {
        var optional;
        DonationService.getDonationFormInfo('form_id=' + $scope.donationInfo.form_id + '&fr_id=' + $scope.donationInfo.fr_id).then(function(response) {
          var levels;
          levels = response.data.getDonationFormInfoResponse.donationLevels.donationLevel;
          return angular.forEach(levels, function(level) {
            var amount, classLevel, inputId, levelChecked, levelId, levelLabel, userSpecified;
            levelId = level.level_id;
            amount = level.amount.formatted;
            amount = amount.split('.')[0];
            userSpecified = level.userSpecified;
            inputId = '#level_standardexpanded' + levelId;
            classLevel = 'level' + levelId;
            angular.element(inputId).parent().parent().parent().parent().addClass(classLevel);
            levelLabel = angular.element('.' + classLevel).find('.donation-level-expanded-label p').text();
            levelChecked = angular.element('.' + classLevel + ' .donation-level-label-input-container input').prop('checked');
            return $scope.donationLevels.push({
              levelId: levelId,
              classLevel: classLevel,
              amount: amount,
              userSpecified: userSpecified,
              levelLabel: levelLabel,
              levelChecked: levelChecked
            });
          });
        });
        optional = '<span class="ym-optional">Optional</span>';
        angular.element('#donor_phone_row label').append(optional);
        angular.element('#tr_message_to_participant_row').addClass('hidden');
        angular.element('#billing_info').parent().addClass('billing_info_toggle');
        angular.element('#payment_cc_container').append('<div class="clearfix"></div>');
        angular.element('#responsive_payment_typecc_cvv_row .FormLabelText').text('CVV:');
        employerMatchFields();
        billingAddressFields();
        return donorRecognitionFields();
      };
      return loadForm();
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
    '$scope', '$rootScope', '$location', '$filter', '$timeout', 'TeamraiserParticipantService', 'TeamraiserCompanyService', 'ZuriService', function($scope, $rootScope, $location, $filter, $timeout, TeamraiserParticipantService, TeamraiserCompanyService, ZuriService) {
      var $dataRoot, $defaultPersonalDonors, $defaultResponsivePersonalDonors, setParticipantProgress;
      $dataRoot = angular.element('[data-aha-luminate-root]');
      $scope.participantId = $location.absUrl().split('px=')[1].split('&')[0];
      if ($dataRoot.data('company-id') !== '') {
        $scope.companyId = $dataRoot.data('company-id');
      }
      if ($dataRoot.data('team-id') !== '') {
        $scope.teamId = $dataRoot.data('team-id');
      }
      $scope.eventDate = '';
      $rootScope.numTeams = '';
      $scope.challengeName = '';
      $scope.challengeCompleted = '';
      ZuriService.getZooStudent('1/2', {
        success: function(response) {
          $scope.challengeName = response.data.challenges.current;
          return $scope.challengeCompleted = response.data.challenges.completed;
        },
        error: function(response) {
          return $scope.challengeName = null;
        }
      });
      TeamraiserCompanyService.getCompanies('company_id=' + $scope.companyId, {
        success: function(response) {
          var coordinatorId, eventId, ref, ref1;
          coordinatorId = (ref = response.getCompaniesResponse) != null ? ref.company.coordinatorId : void 0;
          eventId = (ref1 = response.getCompaniesResponse) != null ? ref1.company.eventId : void 0;
          $rootScope.numTeams = response.getCompaniesResponse.company.teamCount;
          return TeamraiserCompanyService.getCoordinatorQuestion(coordinatorId, eventId).then(function(response) {
            return $scope.eventDate = response.data.coordinator.event_date;
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
          } else if (percent < 2) {
            percent = 2;
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

  angular.module('ahaLuminateControllers').controller('RegistrationPtypeCtrl', [
    '$scope', '$timeout', function($scope, $timeout) {
      var $donationLevels, $participationType;
      if (!$scope.participationOptions) {
        $scope.participationOptions = {};
      }
      $participationType = angular.element('.js--registration-ptype-part-types input[name="fr_part_radio"]').eq(0);
      $scope.participationOptions.fr_part_radio = $participationType.val();
      $scope.donationLevels = {
        levels: []
      };
      $donationLevels = angular.element('.js--registration-ptype-donation-levels .donation-level-row-container');
      angular.forEach($donationLevels, function($donationLevel) {
        $donationLevel = angular.element($donationLevel);
        return $scope.donationLevels.levels.push({
          amount: $donationLevel.find('input[type="radio"][name*=".donation_level_form_"]').val(),
          askMessage: $donationLevel.find('.donation-level-description-text').text()
        });
      });
      $scope.toggleDonationLevel = function(levelAmount) {
        $scope.participationOptions.ng_donation_level = levelAmount;
        return angular.forEach($scope.donationLevels.levels, function(donationLevel, donationLevelIndex) {
          if (donationLevel.amount === levelAmount) {
            return $scope.donationLevels.activeLevel = donationLevel;
          }
        });
      };
      $scope.previousStep = function() {
        $scope.ng_go_back = true;
        $timeout(function() {
          return $scope.submitPtype();
        }, 500);
        return false;
      };
      return $scope.submitPtype = function() {
        angular.element('.js--default-ptype-form').submit();
        return false;
      };
    }
  ]);

  angular.module('ahaLuminateControllers').controller('RegistrationRegCtrl', [
    '$scope', function($scope) {
      return $scope.submitReg = function() {
        angular.element('.js--default-reg-form').submit();
        return false;
      };
    }
  ]);

  angular.module('ahaLuminateControllers').controller('RegistrationRegSummaryCtrl', ['$scope', function($scope) {}]);

  angular.module('ahaLuminateControllers').controller('RegistrationTfindCtrl', ['$scope', function($scope) {}]);

  angular.module('ahaLuminateControllers').controller('RegistrationUtypeCtrl', [
    '$scope', function($scope) {
      $scope.toggleUserType = function(userType) {
        $scope.userType = userType;
        if (userType === 'new') {
          angular.element('.js--default-utype-new-form').submit();
          return false;
        }
      };
      $scope.submitUtypeLogin = function() {
        angular.element('.js--default-utype-existing-form').submit();
        return false;
      };
      $scope.toggleForgotUsername = function(showHide) {
        return $scope.showForgotUsername = showHide === 'show';
      };
      return $scope.submitForgotUsername = function() {
        angular.element('.js--default-utype-send-username-form').submit();
        return false;
      };
    }
  ]);

  angular.module('ahaLuminateControllers').controller('RegistrationWaiverCtrl', [
    '$scope', function($scope) {
      $scope.submitWaiver = function() {
        angular.element('.js--registration-waiver-form').submit();
        return false;
      };
      return $scope.submitWaiver();
    }
  ]);

  angular.module('ahaLuminateControllers').controller('SchoolSearchCtrl', [
    '$scope', '$rootScope', 'CsvService', 'UtilsService', 'TeamraiserCompanyService', function($scope, $rootScope, Csv, Utils, TeamraiserCompanyService) {
      $scope.states = [];
      $scope.schools = [];
      $scope.schoolList = {
        sortProp: 'SCHOOL_NAME',
        sortDesc: false,
        totalItems: 0,
        currentPage: 1,
        numPerPage: 5
      };
      $scope.setStates = function() {
        var i, list, school, schools, states;
        list = {};
        states = [];
        states.push({
          'id': '0',
          'label': 'Filter Results by State'
        });
        schools = $scope.schools;
        i = 0;
        while (i < schools.length) {
          school = schools[i];
          if (school.SCHOOL_STATE && school.SCHOOL_STATE !== '' && angular.isUndefined(list[school.SCHOOL_STATE])) {
            list[school.SCHOOL_STATE] = school.SCHOOL_STATE;
            states.push({
              'id': school.SCHOOL_STATE,
              'label': school.SCHOOL_STATE,
              'SCHOOL_STATE': school.SCHOOL_STATE
            });
          }
          i++;
          $scope.states = states;
          $scope.schoolList.stateFilter = states[0];
        }
      };
      $scope.paginate = function(value) {
        var begin, end, index;
        begin = ($scope.schoolList.currentPage - 1) * $scope.schoolList.numPerPage;
        end = begin + $scope.schoolList.numPerPage;
        index = $scope.schools.indexOf(value);
        return begin <= index && index < end;
      };
      TeamraiserCompanyService.getSchools({
        success: function(csv) {
          var schools;
          schools = Csv.toJson(csv);
          $scope.schools = schools;
          $scope.schoolList.totalItems = schools.length;
          $scope.setStates();
        },
        failure: function(response) {}
      });
    }
  ]);

  angular.module('ahaLuminateControllers').controller('TeamPageCtrl', [
    '$scope', '$location', function($scope, $location) {
      return $scope.teamId = $location.absUrl().split('team_id=')[1].split('&')[0];
    }
  ]);

  angular.module('ahaLuminateApp').directive('companyParticipantList', [
    'APP_INFO', function(APP_INFO) {
      return {
        templateUrl: APP_INFO.rootPath + 'dist/jump-hoops/html/directive/companyParticipantList.html',
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
    }
  ]);

  angular.module('ahaLuminateApp').directive('companyTeamList', [
    'APP_INFO', function(APP_INFO) {
      return {
        templateUrl: APP_INFO.rootPath + 'dist/jump-hoops/html/directive/companyTeamList.html',
        restrict: 'E',
        replace: true,
        scope: {
          companyName: '=',
          companyId: '=',
          frId: '=',
          teams: '='
        }
      };
    }
  ]);

  angular.module('ahaLuminateApp').directive('schoolList', function() {
    return {
      template: '<table class="table table-responsive table-striped ym-list ym-list--school-list"> <thead class="ym-list__header"> <th class="ym-list__column ym-list__column--school"> School </th> <th class="ym-list__column ym-list__column--city"> City </th> <th class="ym-list__column ym-list__column--state"> State </th> <th class="ym-list__column ym-list__column--team-leader"> Team Leader </th> </thead> <tbody> <tr class="ym-list__row" ng-repeat="school in schools | filter:{SCHOOL_NAME:nameFilter}| filter:{SCHOOL_STATE:stateFilter}"> <td class="ym-list__column ym-list__column--school">{{school.SCHOOL_NAME}}<br/> <a class="btn btn-primary btn-md" ng-href="#">Sign Up</a> </td><td class="ym-list__column ym-list__column--city">{{school.SCHOOL_CITY}}</td><td class="ym-list__column ym-list__column--state">{{school.SCHOOL_STATE}}</td><td class="ym-list__column ym-list__column--team-leader">{{school.COORDINATOR_FIRST_NAME}} {{school.COORDINATOR_LAST_NAME}}</td></tr></tbody></table>',
      restrict: 'E',
      replace: true,
      require: 'ngModel',
      scope: {
        schools: '=',
        nameFilter: '=',
        stateFilter: '='
      }
    };
  });

}).call(this);
