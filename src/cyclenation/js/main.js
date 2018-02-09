'use strict';
(function ($) {

    $(document).ready(function ($) {
        /*************/
        /* Namespace */
        /*************/
        window.cd = {};

        // BEGIN WRAPPER JS

        /***************/
        /* NAV SCRIPTS */
        /***************/
        // Sticky nav
        var stickyToggle = function (sticky, stickyWrapper, scrollElement) {
          var stickyHeight = sticky.outerHeight();
          // var stickyTop = stickyWrapper.offset().top;
          var stickyTop = stickyWrapper.offset().top + 300;
          if (scrollElement.scrollTop() >= stickyTop) {
            stickyWrapper.height(stickyHeight);
            sticky.addClass('is-sticky');
          } else {
            sticky.removeClass('is-sticky');
            stickyWrapper.height('auto');
          }
        };

        // Find all data-toggle="sticky-onscroll" elements
        $('[data-toggle="sticky-onscroll"]').each(function () {
          var sticky = $(this);
          var stickyWrapper = $('<div>').addClass('sticky-wrapper');
          sticky.before(stickyWrapper);
          sticky.addClass('sticky');

          // Scroll & resize events
          $(window).on('scroll.sticky-onscroll resize.sticky-onscroll', function () {
            stickyToggle(sticky, stickyWrapper, $(this));
          });

          // On page load
          stickyToggle(sticky, stickyWrapper, $(window));
        });
        // END WRAPPER JS


        // BEGIN LANDING PAGES
        /******************/
        /* SEARCH SCRIPTS */
        /******************/
        var eventType = 'CycleNation';

        cd.getParticipants = function (firstName, lastName) {
          luminateExtend.api({
              api: 'teamraiser',
              data: 'method=getParticipants' +
                '&first_name=' + ((firstName !== undefined) ? firstName : '') +
                '&last_name=' + ((lastName !== undefined) ? lastName : '') +
                '&event_type=' + eventType +
                '&list_page_size=25' +
                '&response_format=json' +
                '&list_sort_column=first_name' +
                '&list_ascending=true',
              callback: {
                success: function (response) {
                  if (response.getParticipantsResponse.totalNumberResults === '0') {
                    // no search results
                    $('#error-participant').removeAttr('hidden').text('Sorry. Your search did not return any results.');
                  } else {
                    var participants = luminateExtend.utils.ensureArray(response.getParticipantsResponse.participant);
                    $('#participant_results').removeAttr('hidden');

                    $(participants).each(function (i, participant) {
                        // var formattedDate = luminateExtend.utils.simpleDateFormat(participant.event_date, 'MMMM d, yyyy');
                        var donFormId = participant.donationUrl;
                        // TODO - update participant result markup
                        $('#participant_rows').append(
                        //     '<tr>' +
                        //     '<td>' + participant.name.first + ' ' + participant.name.last + '</td>' +
                        //     '<td>' + participant.eventName + '</td>' +
                        //     '<td>' + ((participant.teamName !== null) ? participant.teamName : '') + '</td>' +
                        //     '<td><button type="button" class="button btn-block btn-tertiary btn-block participant-gift" data-credit-id="' + participant.consId +
                        //     '" data-dfid="' + donFormId +
                        //     '" data-frid="' + participant.eventId +
                        //     '" data-gift-designee="' + participant.name.first + ' ' + participant.name.last + '">Select</button></td>' +
                        //     '</tr>'
                      );
                    });

                  $('#participant_results').removeAttr('hidden');

                }
              },
              error: function (response) {
                $('#error-participant').removeAttr('hidden').text(response.errorResponse.message);

              }
            }
          });
      };

      cd.getEvents = function (eventName) {
        luminateExtend.api({
          api: 'teamraiser',
          data: 'method=getTeamraisersByInfo' +
            '&name=' + eventName +
            '&event_type=' + eventType +
            '&list_page_size=25' +
            '&response_format=json' +
            '&list_sort_column=name' +
            '&list_ascending=true',
          callback: {
            success: function (response) {
              if (response.getTeamraisersResponse.totalNumberResults === '0') {
                // no search results
                $('#error-event').removeAttr('hidden').text('Sorry. Your search did not return any results.');
              } else {
                var events = luminateExtend.utils.ensureArray(response.getTeamraisersResponse.teamraiser);
                $('#event_results').removeAttr('hidden');
                $(events).each(function (i, event) {
                  // var formattedDate = luminateExtend.utils.simpleDateFormat(participant.event_date, 'MMMM d, yyyy');
                  var donFormId = event.donate_event_url;
                  // TODO - update event result markup
                  $('#event_rows').append(
                    // '<tr>' +
                    // '<td>' + event.name + '</td>' +
                    // '<td>' + event.location_name + '</td>' +
                    // '<td>' + event.distance + ' mi</td>' +
                    // '<td><button type="button" class="button btn-block btn-tertiary btn-block event-gift" data-credit-id="' + event.id +
                    // '" data-dfid="' + donFormId +
                    // '" data-frid="' + event.id +
                    // '" data-gift-designee="' + event.name + '" >Select</button>' +
                    // '</tr>'
                  );
                  $('#event_results').removeAttr('hidden');

                });

              }
            },
            error: function (response) {
              $('#error-event').removeAttr('hidden').text(response.errorResponse.message);

            }
          }
        });
      };

      cd.getTeams = function (teamName) {
        luminateExtend.api({
          api: 'teamraiser',
          data: 'method=getTeamsByInfo' +
            '&team_name=' + teamName +
            '&event_type=' + eventType +
            '&list_page_size=25' +
            '&response_format=json' +
            '&list_sort_column=name' +
            '&list_ascending=true',
          callback: {
            success: function (response) {
              if (response.getTeamSearchByInfoResponse.totalNumberResults === '0') {
                // no search results
                $('#error-team').removeAttr('hidden').text('Sorry. Your search did not return any results.');
              } else {
                var teams = luminateExtend.utils.ensureArray(response.getTeamSearchByInfoResponse.team);

                $('#team_results').removeAttr('hidden');
                $(teams).each(function (i, team) {
                  // var formattedDate = luminateExtend.utils.simpleDateFormat(participant.event_date, 'MMMM d, yyyy');
                  var donFormId = team.teamDonateURL;
                  // TODO - update team result markup

                  $('#team_rows').append(
                    // '<tr>' +
                    // '<td>' + team.name + '</td>' +
                    // '<td>' + team.captainFirstName + ' ' + team.captainLastName + '</td>' +
                    // '<td><button type="button" class="button btn-block btn-tertiary btn-block team-gift" data-credit-id="' + team.id +
                    // '" data-dfid="' + donFormId +
                    // '" data-frid="' + team.EventId +
                    // '" data-gift-designee="' + team.name + '" >Select</button>' +
                    // '</tr>'
                  );
                  $('#team_results').removeAttr('hidden');

                });

              }
            },
            error: function (response) {
              $('#error-team').removeAttr('hidden').text(response.errorResponse.message);

            }
          }
        });
      };

      cd.getCompanies = function (companyName) {
        luminateExtend.api({
          api: 'teamraiser',
          data: 'method=getCompaniesByInfo' +
            '&team_name=' + companyName +
            '&event_type=' + eventType +
            '&list_page_size=25' +
            '&response_format=json' +
            '&list_sort_column=name' +
            '&list_ascending=true',
          callback: {
            success: function (response) {
              if (response.getCompaniesResponse.totalNumberResults === '0') {
                // no search results
                $('#error-company').removeAttr('hidden').text('Sorry. Your search did not return any results.');
              } else {
                var companies = luminateExtend.utils.ensureArray(response.getcompaniesearchByInfoResponse.company);

                $('#company_results').removeAttr('hidden');
                $(companies).each(function (i, company) {
                  // var formattedDate = luminateExtend.utils.simpleDateFormat(participant.event_date, 'MMMM d, yyyy');

                  $('#company_rows').append(
                    // TODO - update company result markup
                    //  + company.name + company.companyName + company.companyId +
                    //  + company.eventId +
                  );
                  $('#company_results').removeAttr('hidden');

                });

              }
            },
            error: function (response) {
              $('#error-company').removeAttr('hidden').text(response.errorResponse.message);

            }
          }
        });
      };


      // Search by Event Name
      $('#eventSearch').on('submit', function (e) {
        e.preventDefault();
        $('.results-table, .alert').addClass('hidden');
        $('.results-rows').html('');
        var eventName = $('#event_name').val();
        cd.getEvents(eventName);
      });

      // Search by Participant
      $('#participantSearch').on('submit', function (e) {
        e.preventDefault();
        console.log('search participant');
        $('.results-table, .alert').addClass('hidden');
        $('.results-rows').html('');
        var firstName = $('#participant_first_name').val();
        var lastName = $('#participant_last_name').val();
        cd.getParticipants(firstName, lastName);
      });

      // Search by Team
      $('#teamSearch').on('submit', function (e) {
        e.preventDefault();
        $('.results-table, .alert').addClass('hidden');
        $('.results-rows').html('');
        var teamName = $('#team_name').val();
        cd.getTeams(teamName);
      });
// Search by Company
      $('#companySearch').on('submit', function (e) {
        e.preventDefault();
        $('.results-table, .alert').addClass('hidden');
        $('.results-rows').html('');
        var companyName = $('#company_name').val();
        cd.getTeams(companyName);
      });


/******************************/
/* CROSS EVENT ROSTER SCRIPTS */
/******************************/

//   var eventIds = [];
//   var compiledEventsData = [];
//   var compiledParticipantsData = [];
//   var compiledTeamsData = [];
//   var compiledCompaniesData = [];


//   function status(response) {
//     if (response.status >= 200 && response.status < 300) {
//       return Promise.resolve(response)
//     } else {
//       return Promise.reject(new Error(response.statusText))
//     }
//   }

//   function json(response) {
//     return response.json()
//   }

//   function ensureArray(pArray) {
//     if (Array.isArray(pArray)) {
//       return pArray;
//     } else if (pArray) {
//       return [pArray];
//     } else {
//       return [];
//     }
//   }

//   function sort(prop, arr) {
//     prop = prop.split(".");
//     var len = prop.length;

//     arr.sort(function(a, b) {
//       var i = 0;
//       while (i < len) {
//         a = a[prop[i]];
//         b = b[prop[i]];
//         i++;
//       }
//       if (a > b) {
//         return -1;
//       } else if (a < b) {
//         return 1;
//       } else {
//         return 0;
//       }
//     });
//     return arr;
//   }
//   String.prototype.trunc = function(n) {
//     return this.substr(0, n - 1) + (this.length > n ? "&hellip;" : "");
//   };

//   Number.prototype.formatMoney = function(c, d, t) {
//     var n = this,
//       c = isNaN((c = Math.abs(c))) ? 2 : c,
//       d = d == undefined ? "." : d,
//       t = t == undefined ? "," : t,
//       s = n < 0 ? "-" : "",
//       i = String(parseInt((n = Math.abs(Number(n) || 0).toFixed(c)))),
//       j = (j = i.length) > 3 ? j % 3 : 0;
//     return s + (j ? i.substr(0, j) + t : "") + i
//         .substr(j)
//         .replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i)
//             .toFixed(c)
//             .slice(2) : "");
//   };




//       cd.getEventIds = function (eventName) {
//         luminateExtend.api({
//           api: "teamraiser",
//           data:
//             "method=getTeamraisersByInfo" +
//             "&name=%25%25" +
//             "&event_type=" +
//             eventType +
//             "&list_page_size=25" +
//             "&response_format=json" +
//             "&list_sort_column=name" +
//             "&list_ascending=true",
//           callback: {
//             success: function(response) {
//               if (
//                 response.getTeamraisersResponse.totalNumberResults ===
//                 "0"
//               ) {
//                 // no events returned
//                 console.log('getEventIds did not return any events or IDs');
//               } else {
//                 var teamraiserData = luminateExtend.utils.ensureArray(
//                   response.getTeamraisersResponse.teamraiser
//                 );
//                     console.log("run getEventIds success");
//                     teamraiserData.map(function(event) {
//                       eventIds.push(event.id);
//                     });

// // TODO - add promise to wait until all eventIds have pushed to array
//         console.log("fire getTopEvents");
//         var promises = eventIds.map(eventId =>
//           fetch(
//             luminateExtend.global.path.nonsecure +
//               "PageServer/?pagename=getTopEventsData&fr_id=" +
//               eventId +
//               "&pgwrap=n"
//           )
//             .then(status)
//             .then(json)
//         );
//         Promise.all(promises).then(data => {
//           console.log("Event promise data: " + data);
//           compileEventData(data);
//           buildEventList();
//         });

//         // call APIs to capture top teams, participants and companies here
//         cd.getTopParticipants(eventIds);
//         cd.getTopTeams(eventIds);

         
//               }
//             },
//             error: function(response) {
//                   console.log('Error retriving getEventIds');
//             }
//           }
//         });
//       };

//       cd.getEventIds();



//   cd.compileEventData = function(data) {
//     console.log("running compileEventData");

//     data.forEach(function(event, i) {
//       console.log("eventTotal: " + event.getTopEventsDataResponse.teamraiserData.total);
//       var eventName = event.getTopEventsDataResponse.teamraiserData.name.trunc(25);
//       var eventTotal = Number(event.getTopEventsDataResponse.teamraiserData.total
//           .replace("$", "")
//           .replace(",", ""));

//       var eventId = event.getTopEventsDataResponse.teamraiserData.id;
//       // TODO - push these values to a database
//       compiledEventsData.push({ eventName, eventTotal, eventId });
//     });
//   }

//   cd.buildEventList = function() {
//     console.log("final compiled data: " + JSON.stringify(compiledEventsData));
//     // Sort events descending by amount raised and trim array to the top 5 events
//     // TODO - compile total raised across all events for future use on page??
//     var sortedEventsData = sort("eventTotal", compiledEventsData).slice(0, 5);

//     sortedEventsData.forEach(function(event, i) {
//       // Only show events that have raised more than $0
//       if (event.eventTotal > 0) {
//         var formattedTotal = event.eventTotal.formatMoney(0);
//         var eventData = `<a href="${luminateExtend.global.path.nonsecure}TR/?pg=entry&fr_id=${event.eventId}">${event.eventName}</a> <span class="pull-right">$${formattedTotal}</span>`;

//         var list = document.getElementById("topEventsList");
//         var eventItem = document.createElement("li");
//         eventItem.innerHTML = eventData;
//         list.appendChild(eventItem);
//       }
//     });
//   }

//   /* #### BEGIN TOP PARTICIPANTS #### */
//   cd.getTopParticipants = function(eventIds) {
//     // TODO - call getParticipants in order to retrieve event name data? Or store eventId on map call and make multiple calls to get the name? Not sure there's a clean way to tack on eventId to each participant object in the response data. Might be better just to do the full participant search IF a link to their page AND/OR event name is required
//     console.log("fire getTopParticipants");

//     var promises = eventIds.map(eventId =>
//       fetch(
//         luminateExtend.global.path.secure +
//           "CRTeamraiserAPI?method=getTopParticipantsData&api_key=" +
//           luminateExtend.global.apiKey +
//           "&v=1.0&response_format=json&fr_id=" +
//           eventId
//       )
//         .then(status)
//         .then(json)
//     );
//     Promise.all(promises).then(data => {
//       // console.log('getTopParticipants eventIds: ' + JSON.stringify(eventIds));
//       // console.log('getTopParticipants data: ' + JSON.stringify(data));
//       cd.compileParticipantData(data);
//       cd.buildParticipantList();
//     });
//   }

//   cd.compileParticipantData = function(eventsParticipants) {
//     console.log("running compileParticipantData");
//     // console.log('compileParticipantData data: ' + JSON.stringify(eventsParticipants));
//     eventsParticipants.forEach(function(eventParticipants, i) {
//       if (eventParticipants.getTopParticipantsDataResponse.teamraiserData) {
//         var eventParticipantsData = ensureArray(eventParticipants.getTopParticipantsDataResponse.teamraiserData);

//         // console.log('ensureArray: ' + JSON.stringify(eventParticipants));
//         eventParticipantsData.forEach(function(participants, i) {
//           var consName = participants.name.trunc(25);
//           var consTotal = Number(participants.total
//               .replace("$", "")
//               .replace(",", ""));
//           var consId = participants.id;
//           compiledParticipantsData.push({ consName, consTotal, consId });
//         });
//       }
//     });
//     // console.log('compiledParticipantsData: ' + JSON.stringify(compiledParticipantsData));
//   }

//   cd.buildParticipantList = function() {
//     // Sort participants descending by amount raised and trim array to the top 5 participants
//     var sortedParticipantsData = sort("consTotal", compiledParticipantsData).slice(0, 5);

//     sortedParticipantsData.forEach(function(participant, i) {
//       // Only show participant that have raised more than $0
//       if (participant.consTotal > 0) {
//         // TODO - add and get eventId from participant array so personal page URL will work
//         var formattedTotal = participant.consTotal.formatMoney(0);
//         // var participantData = `<a href="${luminateExtend.global.path.nonsecure}TR/?pg=personal&fr_id=${participant.consId}">${participant.consName}</a> <span class="pull-right">$${participant.consTotal}</span>`;
//         var participantData = `${participant.consName} <span class="pull-right">$${formattedTotal}</span>`;

//         var list = document.getElementById("topParticipantsList");
//         var participantItem = document.createElement("li");
//         participantItem.innerHTML = participantData;
//         list.appendChild(participantItem);
//       }
//     });
//   }

//   /* #### BEGIN TOP TEAMS #### */
//   cd.getTopTeams = function(eventIds) {
//     // TODO - call getParticipants in order to retrieve event name data? Or store eventId on map call and make multiple calls to get the name? Not sure there's a clean way to tack on eventId to each participant object in the response data. Might be better just to do the full participant search IF a link to their page AND/OR event name is required
//     console.log("fire getTopTeams");

//     var promises = eventIds.map(eventId =>
//       fetch(
//         luminateExtend.global.path.secure +
//           "CRTeamraiserAPI?method=getTopTeamsData&api_key=" +
//           luminateExtend.global.apiKey +
//           "&v=1.0&response_format=json&fr_id=" +
//           eventId
//       )
//         .then(status)
//         .then(json)
//     );
//     Promise.all(promises).then(data => {
//       // console.log('getTopTeams eventIds: ' + JSON.stringify(eventIds));
//       // console.log('getTopTeams data: ' + JSON.stringify(data));
//       cd.compileTeamData(data);
//       cd.buildTeamList();
//     });
//   }

//   cd.compileTeamData = function(eventsTeams) {
//     console.log("running compileTeamData");
//     // console.log('compileTeamData data: ' + JSON.stringify(eventsTeams));
//     eventsTeams.forEach(function(eventTeams, i) {
//       if (eventTeams.getTopTeamsDataResponse.teamraiserData) {
//         var eventTeamsData = ensureArray(eventTeams.getTopTeamsDataResponse.teamraiserData);

//         eventTeamsData.forEach(function(teams, i) {
//           var teamName = teams.name.trunc(25);
//           var teamTotal = Number(teams.total
//               .replace("$", "")
//               .replace(",", ""));
//           var teamId = teams.id;
//           // TODO - push these values to a database
//           compiledTeamsData.push({ teamName, teamTotal, teamId });
//         });
//       }
//     });
//     // console.log('compiledParticipantsData: ' + JSON.stringify(compiledParticipantsData));
//   }

//   cd.buildTeamList = function() {
//     // Sort participants descending by amount raised and trim array to the top 5 participants
//     var sortedTeamsData = sort("teamTotal", compiledTeamsData).slice(0, 5);

//     sortedTeamsData.forEach(function(team, i) {
//       // Only show team that have raised more than $0
//       if (team.teamTotal > 0) {
//         // TODO - add and get eventId from team array so personal page URL will work
//         var formattedTotal = team.teamTotal.formatMoney(0);

//         // var teamData = `<a href="${luminateExtend.global.path.nonsecure}TR/?pg=team&fr_id=${team.teamId}">${team.teamName}</a> <span class="pull-right">$${team.teamTotal}</span>`;
//         var teamData = `${team.teamName} <span class="pull-right">$${formattedTotal}</span>`;

//         var list = document.getElementById("topTeamsList");
//         var teamItem = document.createElement("li");
//         teamItem.innerHTML = teamData;
//         list.appendChild(teamItem);
//       }
//     });
//   }


      // END LANDING PAGES


    });
}(jQuery));
