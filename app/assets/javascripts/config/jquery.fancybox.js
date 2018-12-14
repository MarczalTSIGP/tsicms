//= require jquery.fancybox/jquery.fancybox.min

$(document).on('turbolinks:load', function() {
  $('[data-fancybox="gallery"]').fancybox({
    buttons: [
      "slideShow",
      "thumbs",
      "close"
    ],
  });
});
