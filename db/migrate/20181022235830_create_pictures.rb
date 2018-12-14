class CreatePictures < ActiveRecord::Migration[5.2]
  def change
    create_table :pictures do |t|
      t.string :label
      t.string :image
      t.belongs_to :gallery, index: true

      t.timestamps
    end
  end
end
