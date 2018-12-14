//= require jquery-easing/jquery.easing.min.js
//= require scrollreveal/scrollreveal.min

"use strict";

$(document).on('turbolinks:load', function () {
  TSICMS.scrolling.smooth();
  TSICMS.scrolling.closeResponsiveMenuAfterClick();
  TSICMS.scrolling.reveals();
});

TSICMS.scrolling = {};

TSICMS.scrolling.smooth = function () {
  // Smooth scrolling using jQuery easing
  var scroll_trigger_path = 'a.js-scroll-trigger[href*="#"]:not([href="#"])'

  $(scroll_trigger_path).click(function () {
    var previous_path_location = location.pathname.replace(/^\//, '');
    var current_path_location = this.pathname.replace(/^\//, '');

    var comparation_path_location = previous_path_location == current_path_location;
    var comparation_hostname = location.hostname == this.hostname;

    if (comparation_path_location && comparation_hostname) {
      var target = $(this.hash);
      var target_slice = $('[name=' + this.hash.slice(1) + ']');

      target = target.length ? target : target_slice;

      if (target.length) {
        var target_offset = target.offset().top - 56;

        $('html, body').animate({
          scrollTop: (target_offset)
        }, 1000, "easeInOutExpo");
        return false;
      }
    }
  });
}

TSICMS.scrolling.closeResponsiveMenuAfterClick = function () {
  // Closes responsive menu when a scroll trigger link is clicked
  $('.js-scroll-trigger').click(function () {
    $('.navbar-collapse').collapse('hide');
  });
}

TSICMS.scrolling.reveals = function () {
  // Scroll reveal calls
  window.sr = ScrollReveal();

  sr.reveal('.sr-icon-1', { delay: 200, scale: 0 });
  sr.reveal('.sr-icon-2', { delay: 400, scale: 0 });
  sr.reveal('.sr-icon-3', { delay: 600, scale: 0 });
  sr.reveal('.sr-icon-4', { delay: 800, scale: 0 });
  sr.reveal('.sr-button', { delay: 200, distance: '15px', origin: 'bottom', scale: 0.8 });
  sr.reveal('.sr-contact-1', { delay: 200,scale: 0 });
  sr.reveal('.sr-contact-2', { delay: 400, scale: 0 });
}
