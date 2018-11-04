class AddFixedToStaticPage < ActiveRecord::Migration[5.2]
  def change
    add_column :static_pages, :fixed, :boolean
  end
end
