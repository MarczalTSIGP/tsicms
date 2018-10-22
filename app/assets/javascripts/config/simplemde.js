//= require simplemde.min

TSICMS.markdown_editor = function (el) {
  if ($(el).length > 0)
    new SimpleMDE({ element: $(el)[0] });

  $('.apply-markdown').each( function (index, el) {
    data = $(el).data('markdown');
    html = SimpleMDE.prototype.markdown(data);
    $(el).html(html);
  });
}
