$(document).on "turbolinks:load", ->
  $('[data-toggle="tooltip"]').tooltip()
  img_ids = "#admin_image,
             #recommendation_image,
             #academic_image,
             #company_image,
             #professor_image"
  TSICMS.imagePreview(img_ids)
  TSICMS.loadMarkdownEditor()
  TSICMS.PermalinkGeneratorOnBlur('#static_page_title', '#static_page_permalink')
