class AddGenderToProfessors < ActiveRecord::Migration[5.2]
  def up
    execute <<-SQL
      CREATE TYPE professor_genders AS ENUM ('male', 'female');
    SQL
    add_column :professors, :gender, :professor_genders
  end

  def down
    remove_column :professors, :gender
    execute <<-SQL
      DROP TYPE professor_genders;
    SQL
  end
end
