$(document).on "turbolinks:load", ->
  TSICMS.imagePreview("#admin_image, #recommendation_image")
  $('[data-toggle="tooltip"]').tooltip()
