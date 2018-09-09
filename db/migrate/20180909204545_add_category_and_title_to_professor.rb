class AddCategoryAndTitleToProfessor < ActiveRecord::Migration[5.2]
  def change
    add_reference :professors, :professor_titles, foreign_key: true

    add_reference :professors, :professor_categories, foreign_key: true
  end
end
