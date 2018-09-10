class AddCategoryAndTitleToProfessor < ActiveRecord::Migration[5.2]
  def change
    add_reference :professors, :professor_title, foreign_key: true

    add_reference :professors, :professor_category, foreign_key: true
  end
end
