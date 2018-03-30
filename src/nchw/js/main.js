'use strict';
(function ($) {
  $(document).ready(function ($) {
    // New NCHW JS goes here...
    // Example of retrieving data attribute (fr_id) from the body tag
    var evID = $('body').data('fr-id') ? $('body').data('fr-id') : null;
    console.log("Event ID = ",evID);

    //mobile nav
    jQuery('#mobileNav .sub-nav-toggle-link').click(function () {
      //slide up all the link lists
      jQuery('.sub-nav').slideUp();
      jQuery(this).removeClass('sub-nav-open').parent().removeClass('sub-active');
      //slide down the link list below the h3 clicked - only if its closed
      if (!jQuery(this).next().is(':visible')) {
        jQuery(this).next().slideDown();
        jQuery(this).removeClass('sub-nav-open').parent().removeClass('sub-active');
        jQuery(this).addClass('sub-nav-open').parent().addClass('sub-active');
      }
    });

    //sponsor slider
    jQuery('.sponsor_slider .local_sponsors').unslider({
      selectors: {
        container: 'div.tr_sponsorship_logos',
        slides: 'div.tr_sponsorship_logo'
      },
      autoplay: true
    });

    if ($('body').is('.pg_entry')) {
      // Greeting page-specific JS goes here
      console.log('testing the new main.js file')
    }
  });
}(jQuery));
