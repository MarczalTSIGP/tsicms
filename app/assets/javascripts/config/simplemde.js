//= require simplemde/simplemde.min

$(document).on('turbolinks:load', function() {
  TSICMS.loadMarkdownEditor();
});

TSICMS.loadMarkdownEditor = function () {
   $('.markdown-editor').each(function () {
      var id = $(this).attr('id');
      new SimpleMDE({ element: document.getElementById(id) });
   });

   $('.markdown-content').each(function () {
      var markdown = $(this).data('markdown');
      var html = SimpleMDE.prototype.markdown(markdown);

      $(this).html(html);
   })
}
