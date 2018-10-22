$(document).on "turbolinks:load", ->
  $('[data-toggle="tooltip"]').tooltip()
  TSICMS.imagePreview("#admin_image, #recommendation_image")
  TSICMS.imagePreview("#academic_image, #professor_image")
  TSICMS.markdown_editor("#discipline_menu")
  TSICMS.markdown_editor("#faq_answer")



