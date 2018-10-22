class AddIndexToProfessors < ActiveRecord::Migration[5.2]
  def change
    add_index :professors, :gender
  end
end
