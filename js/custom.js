(function($) {
  $(document).ready(function() {
    //sponsor slider
    jQuery('.sponsor_slider').unslider({
      selectors: {
        container: 'div.tr_sponsorship_logos',
        slides: 'div.tr_sponsorship_logo'
      }, 
      autoplay: true
    });
    $('.aha-mobile-header button.btn').click(function() {
      $('.aha-mobile-header').toggleClass("open");
    });
   	//if (location.href.indexOf("Donation2") > 0) {
  	//	jQuery('body').addClass("registration donation");
    //}
    if (jQuery('body').hasClass('donation') && !jQuery('body').hasClass('donation-thank-you')) {
      //Change donation level active style
      //$radioCheckbox = jQuery('body').find('input[type="checkbox"], input[type="radio"]');
      //$radioCheckbox.replaceCheckRadio();
      //setActiveDonationLevel();
    }
    if (location.href.indexOf("Donation2") > 0) {
      //$('body').addClass("registration donation"); 
      //$('form#ProcessForm').before('<div class="header-container col-xs-12 col-sm-12 col-md-5 col-lg-6"><div class="campaign-banner-container"><h1 class="text--staggered"></h1></div></div>');
      //$('form#ProcessForm').addClass("col-xs-12 col-sm-12 col-md-7 col-lg-6");
      //$('.donation-form-content').before($('.form-progress-bar')).addClass("section-container");		

      var eid = jQuery('input[name=FR_ID]').val();
      var dtype = (jQuery('input[name=PROXY_TYPE]').val() == 20) ? "p" : "t";
      var pid = (dtype == "p") ? jQuery('input[name=PROXY_ID]').val() : "";
      var tid = (dtype == "t") ? jQuery('input[name=PROXY_ID]').val() : "";

      jQuery.getJSON("https://secure3.convio.net/heart/site/SPageNavigator/heartwalk_tr_info.html?pgwrap=n&fr_id="+eid+"&team_id="+tid+"&cons_id="+pid+"&callback=?",function(data2){
        //$('.campaign-banner-container h1').html(data2.event_title).each(divTitleWords);
        if (data2.team_name != "") {
          jQuery('.donation-form-content').before('<div class="donation-detail"><strong>Donating to Team Name:</strong><br/>'+data2.team_name+'</div>');
        }
        if (data2.part_name != " ") {
          jQuery('.donation-form-content').before('<div class="donation-detail"><strong>Donating to Participant:</strong><br/>'+data2.part_name+'</div>');
        }
      });
    }
  });
})(jQuery);

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

!function($){return $?($.Unslider=function(t,n){var e=this;return e._="unslider",e.defaults={autoplay:!1,delay:3e3,speed:750,easing:"swing",keys:{prev:37,next:39},nav:!0,arrows:{prev:'<a class="'+e._+'-arrow prev">Prev</a>',next:'<a class="'+e._+'-arrow next">Next</a>'},animation:"horizontal",selectors:{container:"ul:first",slides:"li"},animateHeight:!1,activeClass:e._+"-active",swipe:!0,swipeThreshold:.2},e.$context=t,e.options={},e.$parent=null,e.$container=null,e.$slides=null,e.$nav=null,e.$arrows=[],e.total=0,e.current=0,e.prefix=e._+"-",e.eventSuffix="."+e.prefix+~~(2e3*Math.random()),e.interval=null,e.init=function(t){return e.options=$.extend({},e.defaults,t),e.$container=e.$context.find(e.options.selectors.container).addClass(e.prefix+"wrap"),e.$slides=e.$container.children(e.options.selectors.slides),e.setup(),$.each(["nav","arrows","keys","infinite"],function(t,n){e.options[n]&&e["init"+$._ucfirst(n)]()}),jQuery.event.special.swipe&&e.options.swipe&&e.initSwipe(),e.options.autoplay&&e.start(),e.calculateSlides(),e.$context.trigger(e._+".ready"),e.animate(e.options.index||e.current,"init")},e.setup=function(){e.$context.addClass(e.prefix+e.options.animation).wrap('<div class="'+e._+'" />'),e.$parent=e.$context.parent("."+e._);var t=e.$context.css("position");"static"===t&&e.$context.css("position","relative"),e.$context.css("overflow","hidden")},e.calculateSlides=function(){if(e.total=e.$slides.length,"fade"!==e.options.animation){var t="width";"vertical"===e.options.animation&&(t="height"),e.$container.css(t,100*e.total+"%").addClass(e.prefix+"carousel"),e.$slides.css(t,100/e.total+"%")}},e.start=function(){return e.interval=setTimeout(function(){e.next()},e.options.delay),e},e.stop=function(){return clearTimeout(e.interval),e},e.initNav=function(){var t=$('<nav class="'+e.prefix+'nav"><ol /></nav>');e.$slides.each(function(n){var i=this.getAttribute("data-nav")||n+1;$.isFunction(e.options.nav)&&(i=e.options.nav.call(e.$slides.eq(n),n,i)),t.children("ol").append('<li data-slide="'+n+'">'+i+"</li>")}),e.$nav=t.insertAfter(e.$context),e.$nav.find("li").on("click"+e.eventSuffix,function(){var t=$(this).addClass(e.options.activeClass);t.siblings().removeClass(e.options.activeClass),e.animate(t.attr("data-slide"))})},e.initArrows=function(){e.options.arrows===!0&&(e.options.arrows=e.defaults.arrows),$.each(e.options.arrows,function(t,n){e.$arrows.push($(n).insertAfter(e.$context).on("click"+e.eventSuffix,e[t]))})},e.initKeys=function(){e.options.keys===!0&&(e.options.keys=e.defaults.keys),$(document).on("keyup"+e.eventSuffix,function(t){$.each(e.options.keys,function(n,i){t.which===i&&$.isFunction(e[n])&&e[n].call(e)})})},e.initSwipe=function(){var t=e.$slides.width();"fade"!==e.options.animation&&e.$container.on({movestart:function(t){return t.distX>t.distY&&t.distX<-t.distY||t.distX<t.distY&&t.distX>-t.distY?!!t.preventDefault():void e.$container.css("position","relative")},move:function(n){e.$container.css("left",-(100*e.current)+100*n.distX/t+"%")},moveend:function(n){Math.abs(n.distX)/t>e.options.swipeThreshold?e[n.distX<0?"next":"prev"]():e.$container.animate({left:-(100*e.current)+"%"},e.options.speed/2)}})},e.initInfinite=function(){var t=["first","last"];$.each(t,function(n,i){e.$slides.push.apply(e.$slides,e.$slides.filter(':not(".'+e._+'-clone")')[i]().clone().addClass(e._+"-clone")["insert"+(0===n?"After":"Before")](e.$slides[t[~~!n]]()))})},e.destroyArrows=function(){$.each(e.$arrows,function(t,n){n.remove()})},e.destroySwipe=function(){e.$container.off("movestart move moveend")},e.destroyKeys=function(){$(document).off("keyup"+e.eventSuffix)},e.setIndex=function(t){return 0>t&&(t=e.total-1),e.current=Math.min(Math.max(0,t),e.total-1),e.options.nav&&e.$nav.find('[data-slide="'+e.current+'"]')._active(e.options.activeClass),e.$slides.eq(e.current)._active(e.options.activeClass),e},e.animate=function(t,n){if("first"===t&&(t=0),"last"===t&&(t=e.total),isNaN(t))return e;e.options.autoplay&&e.stop().start(),e.setIndex(t),e.$context.trigger(e._+".change",[t,e.$slides.eq(t)]);var i="animate"+$._ucfirst(e.options.animation);return $.isFunction(e[i])&&e[i](e.current,n),e},e.next=function(){var t=e.current+1;return t>=e.total&&(t=0),e.animate(t,"next")},e.prev=function(){return e.animate(e.current-1,"prev")},e.animateHorizontal=function(t){var n="left";return"rtl"===e.$context.attr("dir")&&(n="right"),e.options.infinite&&e.$container.css("margin-"+n,"-100%"),e.slide(n,t)},e.animateVertical=function(t){return e.options.animateHeight=!0,e.options.infinite&&e.$container.css("margin-top",-e.$slides.outerHeight()),e.slide("top",t)},e.slide=function(t,n){if(e.options.animateHeight&&e._move(e.$context,{height:e.$slides.eq(n).outerHeight()},!1),e.options.infinite){var i;n===e.total-1&&(i=e.total-3,n=-1),n===e.total-2&&(i=0,n=e.total-2),"number"==typeof i&&(e.setIndex(i),e.$context.on(e._+".moved",function(){e.current===i&&e.$container.css(t,-(100*i)+"%").off(e._+".moved")}))}var o={};return o[t]=-(100*n)+"%",e._move(e.$container,o)},e.animateFade=function(t){var n=e.$slides.eq(t).addClass(e.options.activeClass);e._move(n.siblings().removeClass(e.options.activeClass),{opacity:0}),e._move(n,{opacity:1},!1)},e._move=function(t,n,i,o){return i!==!1&&(i=function(){e.$context.trigger(e._+".moved")}),t._move(n,o||e.options.speed,e.options.easing,i)},e.init(n)},$.fn._active=function(t){return this.addClass(t).siblings().removeClass(t)},$._ucfirst=function(t){return(t+"").toLowerCase().replace(/^./,function(t){return t.toUpperCase()})},$.fn._move=function(){return this.stop(!0,!0),$.fn[$.fn.velocity?"velocity":"animate"].apply(this,arguments)},void($.fn.unslider=function(t){return this.each(function(){var n=$(this);if("string"==typeof t&&n.data("unslider")){t=t.split(":");var e=n.data("unslider")[t[0]];if($.isFunction(e))return e.apply(n,t[1]?t[1].split(","):null)}return n.data("unslider",new $.Unslider(n,t))})})):console.warn("Unslider needs jQuery")}(window.jQuery);
