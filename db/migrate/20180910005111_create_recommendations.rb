class CreateRecommendations < ActiveRecord::Migration[5.2]
  def change
    create_table :recommendations do |t|
      t.string :title
      t.text :description
      t.string :image
      t.belongs_to :category_recommendation, index: true

      t.timestamps
    end
  end
end
