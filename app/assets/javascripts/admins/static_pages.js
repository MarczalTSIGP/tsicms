//= require simplemde/simplemde.min

$(document).on('turbolinks:load', function() {
  var simplemde = new SimpleMDE({ element: document.getElementById('static_page_content') });
});
