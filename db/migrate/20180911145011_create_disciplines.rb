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
      t.string :initials
      t.references :period, foreign_key: true
      t.timestamps
    end
  end
end
