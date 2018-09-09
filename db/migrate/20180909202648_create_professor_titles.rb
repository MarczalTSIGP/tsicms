class CreateProfessorTitles < ActiveRecord::Migration[5.2]
  def change
    create_table :professor_titles do |t|
      t.string :description
      t.string :abbrev

      t.timestamps
    end
  end
end
