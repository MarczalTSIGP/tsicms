//= require simplemde/simplemde.min

$(document).on('turbolinks:load', function() {
  var simplemde = new SimpleMDE({ element: document.getElementById('static_page_content') });

  $('#static_page_title').on('blur', function () {
    var content = $(this).val();

    var permalinkElement = $('#static_page_permalink');
    var permalink = permalinkElement.val();

    if (permalink === "") {
      generateSlug(permalinkElement, content);
    }
  })
});

function generateSlug(permalinkElement, content) {
  content = content.replace(/\s/gi, '-');
  var slug = content.replace(/[^\w\.\-]/gi, '');

  permalinkElement.val(slug.toLowerCase());
}
