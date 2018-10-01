class CreateProfessors < ActiveRecord::Migration[5.2]
  def change
    create_table :professors do |t|
      t.string :name
      t.string :lattes
      t.text :occupation_area
      t.string :email

      t.belongs_to :professor_title, index: true, foreign_key: true
      t.belongs_to :professor_category, index: true, foreign_key: true

      t.timestamps
    end
  end
end
