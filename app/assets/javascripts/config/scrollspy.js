"use strict";

$(document).on('turbolinks:load', function () {
  TSICMS.scrollspy();
});

TSICMS.scrollspy = function () {
  $('body').scrollspy({
    target: '#mainNav',
    offset: 57
  });
}
