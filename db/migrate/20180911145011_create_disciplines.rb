class CreateDisciplines < ActiveRecord::Migration[5.2]
  def change
    create_table :disciplines do |t|
      t.string :name
      t.string :code
      t.integer :hours
      t.string :menu
      t.references :period, foreign_key:true
      
      t.timestamps
    end
  end
end
