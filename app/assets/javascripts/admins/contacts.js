TSICMS.addEventToShowContactsMessage = function () {
  $("#contacts-index table tbody tr td.tr-link").click(function () {
    window.location = $(this).parent().data("link");
  });
};

TSICMS.addEventToReadAndUnread = function () {
  $("#contacts-index a.remote-link").click(function () {
    url = $(this).attr('href');
    ids = [];
    $('input:checkbox:checked').each(function () {
      ids.push($(this).val())
    });

    $.ajax({
      type: "POST",
      url: url,
      data: {
        _method: 'PUT',
        authenticity_token: $('[name="csrf-token"]')[0].content,
        contact_ids: ids
      },
      dataType: 'json',
      success: function () {
        location.reload();
      }
    });

    console.log(url);
    console.log(ids);

    return false;
  });
};
