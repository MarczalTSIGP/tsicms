class CreateAcademics < ActiveRecord::Migration[5.2]
  def change
    create_table :academics do |t|
      t.string :name
      t.string :image
      t.string :contact
      t.boolean :graduated, default: false
      t.timestamps
    end
  end
end
