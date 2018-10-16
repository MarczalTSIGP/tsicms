//= require simplemde/simplemde.min

$(document).on('turbolinks:load', function() {
  $('.markdown-content').each(function () {
    var markdown = $(this).html();
    var html = SimpleMDE.prototype.markdown(markdown);

    $(this).html(html);
  })
});
