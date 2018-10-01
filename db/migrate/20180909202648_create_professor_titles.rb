class CreateProfessorTitles < ActiveRecord::Migration[5.2]
  def change
    create_table :professor_titles do |t|
      t.string :name, unique: true
      t.string :abbrev, unique: true

      t.timestamps
    end
  end
end
