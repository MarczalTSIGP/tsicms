class AddActivityIdToStaticPage < ActiveRecord::Migration[5.2]
  def change
    add_reference :static_pages, :activity, index: true
    add_foreign_key :static_pages, :activities
  end
end
