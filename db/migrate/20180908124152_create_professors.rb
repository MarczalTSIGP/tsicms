class CreateProfessors < ActiveRecord::Migration[5.2]
  def change
    create_table :professors do |t|
      t.string :name
      t.string :lattes
      t.string :occupation_area
      t.string :email

      t.timestamps
    end
  end
end
