$('#contact_form').html("<%= j render partial: 'home/contact_form' %>");
$('#contact_form .flash_message').html("<%= j render partial: 'shared/flash_messages' %>");

<% flash.clear %>