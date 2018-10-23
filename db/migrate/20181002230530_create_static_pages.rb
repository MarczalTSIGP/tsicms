class CreateStaticPages < ActiveRecord::Migration[5.2]
  def change
    create_table :static_pages do |t|
      t.string :title
      t.string :sub_title
      t.text :content
      t.string :permalink

      t.timestamps
    end
    add_index :static_pages, :permalink, unique: true
  end
end
