class CreateCategoryRecommendations < ActiveRecord::Migration[5.2]
  def change
    create_table :category_recommendations do |t|
      t.string :name, null: false
      t.timestamps
    end

    add_index :category_recommendations, :name, unique: true
  end
end
