class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :description
      t.boolean :posted, default: false
      t.belongs_to :post_category, index: true, foreign_key: true

      t.timestamps
    end
  end
end
