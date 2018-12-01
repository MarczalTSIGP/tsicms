class CreateDisciplines < ActiveRecord::Migration[5.2]
  def change
    create_table :disciplines do |t|
      t.string :name
      t.string :code
      t.integer :hours
      t.integer :theoretical_classes
      t.integer :practical_classes
      t.integer :distance_classes
      t.string :menu
<<<<<<< HEAD
      t.string :initials
      t.references :period, foreign_key:true
      
=======
      t.references :period, foreign_key: true

>>>>>>> 8cc759d03258900840dbab79ab883e0cb84125cb
      t.timestamps
    end
  end
end
