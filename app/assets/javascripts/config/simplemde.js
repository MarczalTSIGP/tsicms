//= require simplemde.min

$(document).on('turbolinks:load', function() {
  //var simplemde = new SimpleMDE();
  if ($("#faq_answer").length > 0)
    var simplemde = new SimpleMDE({ element: $("#faq_answer")[0] });

  $('.apply-markdown').each( function (index, el) {
    console.log(el);
    data = $(el).data('markdown');
    html = SimpleMDE.prototype.markdown(data);
    $(el).html(html);
  });
});

