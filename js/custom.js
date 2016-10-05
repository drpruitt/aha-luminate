(function($) {
  $(document).ready(function() {
    $('.aha-mobile-header button.btn').click(function() {
      $('.aha-mobile-header').toggleClass("open");
    });
    if (jQuery('body').hasClass('donation') && !jQuery('body').hasClass('donation-thank-you')) {
    //Change donation level active style
function setActiveDonationLevel() {
  var $donationLevels = jQuery('body').find('.donation-levels');
  var $donationLevelsRadio = $donationLevels.find('input[type="radio"]');
  var $otherField = $donationLevels.find('.donation-level-user-entered > input');

  $donationLevelsRadio.on('change', function () {
    $donationLevels.find('.js-active').removeClass('js-active');
    var $donationLabel = jQuery(this).parents('.donation-level-input-container').children('label');
    $donationLabel.addClass('js-active');
    if ($donationLabel.next().hasClass('donation-level-user-entered')) {
      //if other selected then make other input required
      $otherField.prop('required', true).attr('data-validation-optional', 'false');
    } else {
      $otherField.prop('required', false).attr('data-validation-optional', 'true').removeClass('form__input--error');
    }
  });
}

//call on a list of checkboxes & radio buttons
jQuery.fn.replaceCheckRadio = function () {
  var isPreviouslyReplaced = false;

  var $inputs = jQuery(this).each(function () {
    var $input = jQuery(this);
    var $span = jQuery('<span></span>');
    var $wrap = jQuery('<span class="input__wrapper"></span>');

    //replace only if it's already hasn't been replaced
    if (!$input.hasClass('js-hidden')) {
      $input.wrap($wrap);

      if ($input.attr('type') == 'checkbox') {
        $span.addClass('checkbox');
        $input.after($span);
      }

      if ($input.attr('type') == 'radio') {
        $span.addClass('radio');
        $input.after($span);
      }

      //hide the input after replacing it, to ensure things are visible on js failure
      $input.addClass('js-hidden');
    } else {
      isPreviouslyReplaced = true;
    }
  });

  //ensures that only 1 click event is assigned to the input
  if (!isPreviouslyReplaced) {
    jQuery('.checkbox, .radio').on('click', function (e) {
      jQuery(this).siblings('input').trigger('click');
    });
  }

  return $inputs;
};
$radioCheckbox = jQuery('body').find('input[type="checkbox"], input[type="radio"]');
$radioCheckbox.replaceCheckRadio();
setActiveDonationLevel();
  }
  });
})(jQuery);
