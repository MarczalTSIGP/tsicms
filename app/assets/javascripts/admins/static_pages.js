'use strict'

TSICMS.PermalinkGeneratorOnBlur = function (from, to) {
   $(from).on('blur', function () {
      var permalinkElement = $(to);
      var permalink = permalinkElement.val();

      if (permalink === "") {
         var content = $(this).val();
         var slug = TSICMS.PermalinkGenerator.generateSlug(content);
         permalinkElement.val(slug);
      }
   });
}
