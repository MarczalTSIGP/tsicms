//=require simplemde.min
$(document).on('turbolinks:load', function() {
//var simplemde = new SimpleMDE();
  if ($("#discipline_menu").length > 0)
    var simplemde = new SimpleMDE({ element: $("#discipline_menu")[0] });
  $('.apply-markdown').each( function (index, el) {
    console.log(el);
    data = $(el).data('markdown');
    html = SimpleMDE.prototype.markdown(data);
    $(el).html(html);
  });
});
