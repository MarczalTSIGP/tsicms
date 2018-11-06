class CreatePeriodProfessors < ActiveRecord::Migration[5.2]
  def change
    create_table :period_professors do |t|
      t.date :date_entry
      t.date :date_out

      t.references :professor, foreign_key: true
      t.references :professor_category, foreign_key: true

      t.timestamps
    end
  end
end
