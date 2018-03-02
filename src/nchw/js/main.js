'use strict';
(function ($) {
  $(document).ready(function ($) {
    // New NCHW JS goes here...
    // Example of retrieving data attribute (fr_id) from the body tag
    var evID = $('body').data('fr-id') ? $('body').data('fr-id') : null;

    if ($('body').is('.pg_entry')) {
      // Greeting page-specific JS goes here
    }
  });
}(jQuery));
