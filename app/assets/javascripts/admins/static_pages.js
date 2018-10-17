//= require simplemde/simplemde.min

$(document).on('turbolinks:load', function() {
  var simplemde = new SimpleMDE({ element: document.getElementById('static_page_content') });

  $('#static_page_title').on('blur', function () {
    var content = $(this).val();

    var permalinkElement = $('#static_page_permalink');
    var permalink = permalinkElement.val();

    if (permalink === "") {
      var slug = generateSlug(content);
      permalinkElement.val(slug);
    }
  })
});

function generateSlug(string) {
  return normalizeCharacters(string).replace(/\s/gi, '-')
                                    .replace(/[^\w\.\-]/gi, '')
                                    .toLowerCase();
}

/**
 * @see https://stackoverflow.com/a/37511463
 */
function normalizeCharacters(string) {
  return string.normalize('NFD')
               .replace(/[\u0300-\u036f]/g, '');
}
