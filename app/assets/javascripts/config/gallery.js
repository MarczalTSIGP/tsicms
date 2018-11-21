//= require magnific-popup/jquery.magnific-popup.min

"use strict";

$(document).on('turbolinks:load', function () {
  TSICMS.gallery();
});

TSICMS.gallery = function () {
  $('.popup-gallery').magnificPopup({
    delegate: 'a',
    type: 'image',
    tLoading: 'Loading image #%curr%...',
    mainClass: 'mfp-img-mobile',
    gallery: {
      enabled: true,
      navigateByImgClick: true,
      preload: [0, 1]
    },
    image: {
      tError: '<a href="%url%">The image #%curr%</a> could not be loaded.'
    }
  });
}
